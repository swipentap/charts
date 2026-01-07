{{/*
Expand the name of the chart.
*/}}
{{- define "certa.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "certa.fullname" -}}
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
{{- define "certa.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "certa.labels" -}}
helm.sh/chart: {{ include "certa.chart" . }}
{{ include "certa.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "certa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "certa.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $key, $value := .Values.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "certa.namespace" -}}
{{- .Values.namespace.name | default "certa" }}
{{- end }}

{{/*
PostgreSQL connection string
*/}}
{{- define "certa.postgresql.connectionString" -}}
Host={{ include "certa.fullname" . }}-postgresql:{{ .Values.postgresql.service.port }};Database={{ .Values.postgresql.env.POSTGRES_DB }};Username={{ .Values.postgresql.env.POSTGRES_USER }};Password={{ .Values.postgresql.env.POSTGRES_PASSWORD }};Port={{ .Values.postgresql.service.port }}
{{- end }}
