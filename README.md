# Minecraft Spectrum Sync

This repository contains the necessary Terraform configuration to automate the process of updating the IP address for a Cloudflare Spectrum Application, namely a Java Minecraft server. By running this Terraform script on a loop or cronjob, you can ensure that the IP address for your app/server is always up-to-date.

## Prerequisites

Before getting started, make sure you have the following:

- A Cloudflare account
- A Minecraft server that you want to protect with the spectrum services
- Terraform installed on your local machine
- An API key provisioned for access to your DNS records as necessary
    - To properly lock down the API key, ensure that it only has the following permissions:
        - Zone -> Zone Settings -> Edit
        - Zone -> DNS -> Edit
        - Include -> Specific Zone -> {Your Domain}

## Getting Started

1. Clone this repository to your local machine.
2. Open the `variables.tf` file and update the variables according to your environment.
    - Alternatively, set the variables in your environment using your preferred approach (`export`, `$env:CLOUDFLARE_*`, etc. )
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform apply` to apply the changes and update the IP address for your server.

## Automation

To automate the process of updating the IP address, you can set up a loop or cronjob to run the `terraform apply` command at regular intervals. This will ensure that your server's IP address is always up-to-date. Included is a script that will run the Terraform accordingly if a change is detected against the public IP of the execution environment.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
