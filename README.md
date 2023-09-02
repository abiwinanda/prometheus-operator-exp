# Prometheus Operator Exp

## Setup

First, install the prometheus operator custom resource objects.

```sh
./setup.sh
```

the setup script will create a namespace called `monitoring` and the prometheus operator will be installed in the namespace.

## Create a Prometheus to Scrape an App's Metrics

First, you need to create a sample app (with metrics available) for prometheus to scrape.

```sh
kubectl apply -f ./sample-app
```

this will create a sample app with metrics avaiable to scrape at `/metric` path. A service monitor object will also be created when running the previous command. A service monitor is required for prometheus to scrape the application service.

Next, create the prometheus instance.

```sh
kubectl apply -f ./prometheus
```

Port forward into the prometheus instance by using `port-forward`

```sh
kubectl port-forward service/prometheus 4000:9090
```

Access localhost port `4000` (or any port you choose) and check whether you have some metrics available.

## Create a Grafana for Dashboarding

Create grafana by using helm

```sh
helm install grafana ./grafana
```

Get the grafana `admin` password.

```sh
kubectl get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Port forward into the grafana

```sh
kubectl port-forward service/grafana 5000:80
```

and login using `admin` user with the previously retrieved password.

## References

- https://prometheus-operator.dev/docs/user-guides/getting-started/
- https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md
