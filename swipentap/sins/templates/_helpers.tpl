{{/*
Expand the name of the chart.
*/}}
{{- define "sins.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "sins.fullname" -}}
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
{{- define "sins.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sins.labels" -}}
helm.sh/chart: {{ include "sins.chart" . }}
{{ include "sins.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sins.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sins.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $key, $value := .Values.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "sins.namespace" -}}
{{- .Values.namespace.name | default "sins" }}
{{- end }}

{{/*
PostgreSQL connection string
*/}}
{{- define "sins.postgresql.connectionString" -}}
Host={{ include "sins.fullname" . }}-postgresql:{{ .Values.postgresql.service.port }};Database={{ .Values.postgresql.env.POSTGRES_DB }};Username={{ .Values.postgresql.env.POSTGRES_USER }};Password={{ .Values.postgresql.env.POSTGRES_PASSWORD }}
{{- end }}
