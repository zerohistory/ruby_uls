# Ruby Univeral Location Service [WIP]

[see http://developer.veriplace.com/devportal/locationAccessOverview]

## Setup

Set your Universal Location Service credentials as ENV variables:

* `ULS_CONSUMER_KEY`
* `ULS_CONSUMER_SECRET`
* `ULS_APPLICATION_TOKEN`
* `ULS_APPLICATION_TOKEN_SECRET`

## Usage (Invitation API only)

Sending an invitation (returns XML response)

    ULS.invite('123-123-1234')

Sending an invitation with a callback URL (returns an XML response)

    ULS.invite('123-123-1234', :callback => "http://example.org/callback")

## Dependencies

    gem install rack ruby-hmac
