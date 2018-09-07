OPENSHIFT-METRICS: STEP-BY-STEP
===============================
Requerimientos:
  - PVs sobre NFS (*)
  - Definición de a donde alertmanager va a enviar alertas
    - por mail: smtp

(*): Si no están creados, crearlos en el NFS

Crear

PREFIX=ocp-np mkdir $PREFIX-prometheus $PREFIX-alertmanager $PREFIX-alertbuffer $PREFIX-grafana

# TODO: Given name, size, prefix, nfsserver, nfspath make a script that generates N pvs with Ni Sizes.

Add snippet to INVENTORY_FILE

# TODO: Automatic Inventory File Update
# Given storage selectors, node_selector, project namespace, few possible configurations, storage sizes
# Add prometheus configuration snippet automatically to inventory file.
# Checkear playbook de agregar afterline en update_firewall, pero con template o file

Run playbook

Enable ports 9100 on nodes, with update-firewall.yaml

Instalar kube-state-metrics
# TODO: Tener una imagen propia de kube-state-metrics:v1.4.0, a veces
# A veces los clusters no llegan a gcr.io/google_containers/kube-state-metrics:v1.4.0

Configuración de prometheus
oc apply -f prometheus-cm.yaml

# Todo config alertmanager
# oc apply -f alertmanager-cm.yaml

Instalar Grafana

Importar dashboards
# TODO: Job que cree los dashboards por curl POST.
# REF: https://github.com/giantswarm/kubernetes-prometheus/tree/master/manifests/grafana/import-dashboards

- Por alguna razón no toma el filtro ,namespace=~"^$Namespace$" en algunos graphs de ocp cluster monitoring v1
- Falta que scrapee métricas del propio prometheus, alertmanager y grafana

Metricas from alertmanager
oc annotate svc kube-state-metrics prometheus.io/scrape='true'

### Alertmanager
- Exporters
. Logfiles
