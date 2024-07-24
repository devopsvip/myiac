# terraform用到的providers
terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.12"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

provider "kind" {}

# 此变量指定kubeconfig的文件输出路径
variable "kind_cluster_config_path" {
  type    = string
  default = "~/.kube/config"
}

# 此输出会在控制台打印kubeconfig内容
output "kubeconfig" {
  value = kind_cluster.default.kubeconfig
}

# 定义k8s集群
resource "kind_cluster" "default" {
  name            = "devopscluster"                             # 集群名称
  node_image      = "ccr.ccs.tencentyun.com/devopsvip/kind:v1.24.0"   #kindest/node:v1.24.0 kind镜像
  kubeconfig_path = pathexpand(var.kind_cluster_config_path)    # kubeconfig路径
  wait_for_ready  = true  # 等待集群节点ready
  
  # kind配置文件
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    
    # Control节点配置
    node {
      role = "control-plane"
      kubeadm_config_patches = [
        <<-EOT
          kind: InitConfiguration
          imageRepository: registry.aliyuncs.com/google_containers
          networking:
            serviceSubnet: 10.0.0.0/16
            apiServerAddress: "0.0.0.0"
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "ingress-ready=true"
          ---
          kind: KubeletConfiguration
          cgroupDriver: systemd
          cgroupRoot: /kubelet
          failSwapOn: false
          ---
          kind: ClusterConfiguration
          etcd:
            local:
              extraArgs:
                listen-metrics-urls: "http://0.0.0.0:2381"
          ---
          kind: ClusterConfiguration
          controllerManager:
            extraArgs:
              bind-address: "0.0.0.0"
          ---
          kind: ClusterConfiguration
          scheduler:
            extraArgs:
              bind-address: "0.0.0.0"
          ---
          kind: KubeProxyConfiguration
          metricsBindAddress: "0.0.0.0:10249"
        EOT

      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
      extra_port_mappings {
        container_port = 6443
        host_port      = 6443
      }
      extra_mounts {
        host_path = "./resolv.conf"
        container_path = "/etc/resolv.conf"
      }
    }

    # worker 节点1
    node {
      role = "worker"
      extra_mounts {
        host_path = "./resolv.conf"
        container_path = "/etc/resolv.conf"
      }
    }

    # worker 节点2
    node {
      role = "worker"
      extra_mounts {
        host_path = "./resolv.conf"
        container_path = "/etc/resolv.conf"
      }
    }
  }
}

# null_resource 用于执行shell命令
# 此步骤用于加载ingress镜像并部署ingress
resource "null_resource" "wait_for_instatll_ingress" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = <<EOF
      sleep 5  
      #kind load  docker-image k8s.gcr.io/ingress-nginx/controller:v1.2.0 --name devopscluster
      #kind load  docker-image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1  --name devopscluster
      kind load docker-image ccr.ccs.tencentyun.com/devopsvip/kube-webhook-certgen:v1.1.1 --name devopscluster
      kind load docker-image ccr.ccs.tencentyun.com/devopsvip/controller:v1.2.0 --name devopscluster
      
      kubectl create ns ingress-nginx
      kubectl apply -f ingress.yaml -n ingress-nginx
      printf "\nWaiting for the nginx ingress controller...\n"
      kubectl wait --namespace ingress-nginx \
        --for=condition=ready pod \
	      --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    EOF
  }

  depends_on = [kind_cluster.default]
}
