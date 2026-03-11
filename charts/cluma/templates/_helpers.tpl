{{/*
Expand the name of the chart.
*/}}
{{- define "cluma.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluma.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluma.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluma.labels" -}}
helm.sh/chart: {{ include "cluma.chart" . }}
{{ include "cluma.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluma.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Frontend labels
*/}}
{{- define "cluma.frontend.labels" -}}
{{ include "cluma.labels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{- define "cluma.frontend.selectorLabels" -}}
app: cluma-frontend
{{- end }}

{{/*
Backend labels
*/}}
{{- define "cluma.backend.labels" -}}
{{ include "cluma.labels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{- define "cluma.backend.selectorLabels" -}}
app: cluma-backend
{{- end }}

{{/*
PostgreSQL labels
*/}}
{{- define "cluma.postgresql.labels" -}}
{{ include "cluma.labels" . }}
app.kubernetes.io/component: postgresql
{{- end }}

{{- define "cluma.postgresql.selectorLabels" -}}
app: postgres
{{- end }}

{{/*
Registry labels
*/}}
{{- define "cluma.registry.labels" -}}
{{ include "cluma.labels" . }}
app.kubernetes.io/component: registry
{{- end }}

{{- define "cluma.registry.selectorLabels" -}}
app: docker-registry
{{- end }}

{{/*
Frontend image
*/}}
{{- define "cluma.frontend.image" -}}
{{- if .Values.frontend.image.repository }}
{{- printf "%s:%s" .Values.frontend.image.repository .Values.frontend.image.tag }}
{{- else }}
{{- printf "%s:%s/cluma-frontend:%s" .Values.global.nodeIP (toString .Values.registry.service.nodePort) .Values.frontend.image.tag }}
{{- end }}
{{- end }}

{{/*
Backend image
*/}}
{{- define "cluma.backend.image" -}}
{{- if .Values.backend.image.repository }}
{{- printf "%s:%s" .Values.backend.image.repository .Values.backend.image.tag }}
{{- else }}
{{- printf "%s:%s/cluma-backend:%s" .Values.global.nodeIP (toString .Values.registry.service.nodePort) .Values.backend.image.tag }}
{{- end }}
{{- end }}

{{/*
PostgreSQL host
*/}}
{{- define "cluma.postgresql.host" -}}
{{- if .Values.config.db.host }}
{{- .Values.config.db.host }}
{{- else }}
{{- printf "postgres.%s.svc.cluster.local" .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Resolve storage class for a component
*/}}
{{- define "cluma.storageClass" -}}
{{- if . }}
storageClassName: {{ . | quote }}
{{- else }}
storageClassName: ""
{{- end }}
{{- end }}
