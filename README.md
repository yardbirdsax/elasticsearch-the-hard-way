# Elasticsearch the Hard Way

This is a series of lessons on how to bootstrap and secure an Elasticsearch cluster, done completely from scratch (other than provisioning the bare metal cloud compute resources and installing the base Elasticsearch build). Inspired by Kelsey Hightower's [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way), I decided to work from the ground up to better understand how Elasticsearch clustering functions, as well as the other components (such as configuring TLS, securing the cluster with X-Pack, etc). This is *not* designed for ease or automation, but for the deepest possible learning experience.

## Copyright

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>

## Pre-requisites

At the moment, this tutorial is using AWS EC2 instances as the base of the lab. I hope in the future to enable provisioning of resources in other cloud platforms, most notably Microsoft Azure and Google Cloud Platform.

At present time (October of 2019), the full lab will cost you around $375 per month if left running full time (or about $0.50 per hour), so it would be wise to ensure the instances are deallocated (but not terminated!) when not in use to save costs. You could arguably use smaller instances, however in trying to replicate what a small sized production deployment might look like I decided to go with the t3.xlarge (4CPU and 16GB RAM) size.

Before proceeding, you'll need to install [Terraform](https://terraform.io), the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html), and ensure that you have the AWS CLI configured (don't use your root key!).

## Table of Contents

1. [Deploying the base lab resources](docs/deploy.md)
