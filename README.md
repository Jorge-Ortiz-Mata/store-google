# Rails Getting Started

This is a template can be used for new applications. It includes the user authentication with Sendgrid to confirm email accounts.

## Local Development

You can use this template for local development. What you need to start developing locally is:

- SENDGRID_EMAIL_VALID='user@email.com'
- SENDGRID_API_KEY='SG.XXX'

In order to implement active storage, you can pass the correct credentials with single or double quotes

- GCP_SERVICE_ACCOUNT = '{ your_credentials }'

And generate a new master key each time.

- Delete the credentialas.yml.enc file
- Generate a new master key with the command: `EDITOR="code --wait" bin/rails credentials:edit`

And that's it. You don't need anything else.

## Production

Once you're ready to deploy your web application to a production environment, make sure to include the following environment variables:

- RAILS_MASTER_KEY
- PSQL_URI

For send emails in production.

- SENDGRID_EMAIL_VALID
- SENDGRID_API_KEY

In order to implement active storage, you can pass the correct credentials without single or double quotes

- GCP_SERVICE_ACCOUNT = { your_credentials }

## Authors

- Jorge Ortiz
- ortiz.mata.jorge@gmail.com
- yorch-devs.com
- San Luis Potosí, S.L.P. México


gcloud iam service-accounts add-iam-policy-binding "yorch-devs-staging@yorch-devs-staging.iam.gserviceaccount.com" --project="yorch-devs-staging" --role="roles/iam.workloadIdentityUser" --member="principalSet://iam.googleapis.com/projects/833586262248/locations/global/workloadIdentityPools/yorch-devs-staging-pool/attribute.repository/Jorge-Ortiz-Mata/store-google"