terraform {
  backend "s3" {
    use_lockfile = true
    encrypt      = true
    # other backend settings are injected durring terraform init in GH Actions
  }
}
