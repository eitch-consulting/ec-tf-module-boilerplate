set dotenv-load

# List all available tasks
default:
    @just --list

# Run all tests (unit tests and integration tests)
tests: test-unit tg-test-basic

# Run offline native unit tests with mock providers
test-unit:
    @echo "=== Initializing Terraform (local only)..."
    @terraform init -backend=false > /dev/null
    @echo "=== Running native Terraform unit tests..."
    terraform test

# Initialize a new module from this boilerplate (replaces placeholder names)
init-module module_name:
    #!/usr/bin/env bash
    set -euo pipefail
    NEW_NAME="{{module_name}}"
    echo "=== Initializing module as '$NEW_NAME'..."
    sed -i -E "s/module[[:space:]]*=[[:space:]]*\"tf-gcp-boilerplate\"/module     = \"$NEW_NAME\"/g" locals.tf
    if [ -f tests/unit.tftest.hcl ]; then
        sed -i -E "s/local\.module_labels\\[\"module\"\\] == \"tf-gcp-boilerplate\"/local.module_labels[\"module\"] == \"$NEW_NAME\"/g" tests/unit.tftest.hcl
    fi
    sed -i "1s/.*/# $NEW_NAME/" README.md
    echo "=== Re-generating documentation..."
    just docs
    echo "=== Successfully initialized module '$NEW_NAME'!"


# Clean up all tests
cleanup-tests: cleanup-tg-basic-test

# Clean up terragrunt-basic-test
cleanup-tg-basic-test:
    @echo "=== Forcing cleanup of terragrunt-basic-test..."
    cd examples/terragrunt-basic-test && terragrunt destroy -auto-approve
    @just cleanup-cache

# Remove all Terraform and Terragrunt caches, state files, and lock files
cleanup-cache:
    @echo "=== Removing cache directories and state files..."
    find . -type d -name ".terraform" -prune -exec rm -rf {} +
    find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} +
    find . -type f -name "*.tfstate*" -exec rm -f {} +
    find . -type f -name ".terraform.lock.hcl" -exec rm -f {} +

# Run test to validate terragrunt integration (needs gcloud logged in)
tg-test-basic:
    #!/usr/bin/env bash
    set -e
    echo "=== Running terragrunt-basic-test..."
    cd examples/terragrunt-basic-test
    trap 'echo "=== Cleaning up test infrastructure..."; terragrunt destroy -auto-approve' EXIT
    terragrunt init
    terragrunt apply -auto-approve

# Generate documentation from code to README.md
docs:
    @echo "=== Generating README.md via terraform-docs..."
    terraform-docs markdown --anchor=false table --output-file README.md ./

# Run shellcheck on all .sh files
shellcheck:
    @echo "=== Running ShellCheck..."
    find . -type f -name '*.sh' -exec shellcheck {} +

# Run formatting, validation, and linting
lint: shellcheck
    @echo "=== Formatting Terraform code..."
    terraform fmt -recursive
    @echo "=== Initializing Terraform (local only)..."
    terraform init -backend=false
    @echo "=== Validating Terraform syntax..."
    terraform validate
    @echo "=== Running TFLint..."
    tflint --recursive

# Verify the module is ready for public release
check-release: lint tests cleanup-tests
    @echo "=== Verifying LICENSE exists..."
    @test -f LICENSE || (echo "Missing LICENSE file!" && exit 1)
    @echo "=== Module is clean, tested, and licensed."
