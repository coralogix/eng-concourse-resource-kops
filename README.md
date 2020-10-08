# Kops Concourse Resource Type

[![Docker Repository on Quay](https://quay.io/repository/coralogix/eng-concourse-resource-kops/status "Docker Repository on Quay")](https://quay.io/repository/coralogix/eng-concourse-resource-kops)

A Concourse resource for validating Kops cluster.

## Source Configuration
* `state_bucket` : _Required_ (`string`). An S3 bucket where the Kops state is located. 
  * `e.g. s3://my-bucket/kube-cluster`.
* `cluster` : Required (`string`). The name of the cluster you want to validate. 
  * `e.g. my-cluster.k8s.cluster.local`.
* `duration` : _Optional_ (`string`).  The time to wait for the cluster to validate.
  * `e.g. 5m (defaults to 10m)`.

### Example Usage

Resource type definition

```yaml
resource_types:
- name: kops
  type: registry-image
  source:
    repository: quay.io/coralogix/eng-concourse-resource-kops
    tag: v1.17.0
```

Validate cluster

```yaml
resources:
- name: kops-validate
  type: kops
  source:
    state_bucket: s3://some-state-bucket/kube-cluster
    cluster: some.cluster.k8s.local
    duration: 20m
```

## Behavior

### `check` : Check for a valid kubernetes cluster using Kops
The Kops binary is checking if the cluster is valid (nodes are `Ready`, and no `Pending` pods) and return `status`. There are no parameters.

### `in` : Fetch the kube config file
The kube config file is exported into the resource's directory as `kubecfg`. There are no parameters.

### `out` : Not supported

## Maintainers
[Ari Becker](https://github.com/ari-becker)
[Oded David](https://github.com/oded-dd)

## License
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) © Coralogix, Inc.
