kubectl create ns monitoring

LATEST=$(curl -s https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | jq -cr .tag_name)

curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/${LATEST}/bundle.yaml \
| sed s/"namespace: default"/"namespace: monitoring"/ \
| kubectl create -f -