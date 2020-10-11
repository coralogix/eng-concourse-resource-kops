# Kops Concourse Resource Type

[![Docker Repository on Quay](https://quay.io/repository/coralogix/eng-concourse-resource-kops/status "Docker Repository on Quay")](https://quay.io/repository/coralogix/eng-concourse-resource-kops)

A Concourse resource to fetch Kops credentials

## Source Configuration
* `state_bucket` : _Required_ (`string`). An S3 bucket where the Kops state is located. 
  * `e.g. s3://my-bucket/kube-cluster`.
* `cluster` : Required (`string`). The name of the cluster you want to validate. 
  * `e.g. my-cluster.k8s.cluster.local`.
* `aws_access_key_id`: Required (`string`). An AWS Access Key ID to use to access the state bucket.
* `aws_secret_access_key` : Required (`string`). An AWS Secret Access Key to use to access the state bucket.

### Example Usage

Resource type definition

```yaml
resource_types:
- name: kops
  type: registry-image
  source:
    repository: quay.io/coralogix/eng-concourse-resource-kops
    tag: v1.18.0
```

Resource definition

```yaml
resources:
- name: kops-validate
  type: kops
  source:
    state_bucket: s3://some-state-bucket/kube-cluster
    cluster: some.cluster.k8s.local
    aws_access_key_id: "((aws_access_key_id))"
    aws_secret_access_key: "((aws_secret_access_key))"
```

## Behavior

### `check` : Check for a valid Kubernetes cluster using Kops
The `check` script uses the Kops binary to check if the cluster is valid (i.e. nodes are `Ready`, and no `Pending` pods in the `kube-system` namespace). 
Depending on whether the cluster is valid, the script will either return `status true`, or else it will return an error.
The intention is to not return a version until the cluster is ready, so that the pipeline will not start until the cluster is ready.

### `in` : Fetch cluster access credentials
The `in` script uses the `kops export kubecfg` command to fetch a `kubeconfig` file with credentials to access the cluster.
This file will be saved in the directory as `kubecfg.yaml`.
There are no parameters.

### `out` : Not supported

## Maintainers
[Ari Becker](https://github.com/ari-becker)
[Shauli Solomovich](https://github.com/ShauliSolomovich)

## License
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) © Coralogix, Inc.
