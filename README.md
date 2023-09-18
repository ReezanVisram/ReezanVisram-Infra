# Reezan Visram - Infra

This is the monorepo containing the infrastructure code for provisioning resources for my projects on GCP.

## Structure

The Terraform code is separated into modules, which are imported by the projects. This makes it easy to manage all the modules for the microservices that make up a project.

Variables are managed in a `tfvars` file for every module, making it easy to see and change all module information.

## What resources are provisioned?

A majority of the microservices use Google Cloud Run with similar configurations, so Terraform makes it super easy to spin up a new, properly configured service. Some services also make use of Google Cloud Secret Manager, as well as Pub/Sub and Cloud SQL.
