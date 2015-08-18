# Grape Swagger Rails Issue Replication

The purpose of this repository is to replicate Issue 13 on Grape Swagger Rails
(see: https://github.com/TinkerDev/grape-swagger-rails/issues/13).

## Gems Used

Unforunately, I ripped this from an existing project so there are more
dependcies than I would like.

1. Rails
1. Devise
1. Doorkeeper
1. wine_bouncer (https://github.com/antek-drzewiecki/wine_bouncer)
1. grape-swagger
1. grape-swagger-rails

# Instructions

1. `git clone https://github.com/whatasunnyday/gsr-api-key && cd gsr-api-key`
1. `rake db:setup` -- This will create a user with the email grape@swagger.com
with the password helloworld.
1. `curl http://localhost:3000/api/hello` should return
`{"id":"unauthenticated","message":"Request failed because user is not authenticated."}`
1.
```
curl -F grant_type=password \
-F username=grape@swagger.com \
-F password=helloworld \
-X POST http://localhost:3000/oauth/token
```
returns something like this (access token and created_at will be different)
```
{"access_token":"a7f7eeb0b70a444c3f755475537bbfd0be5bd49a6fe92bf135d518693372d4af","token_type":"bearer","expires_in":7200,"created_at":1439923237}
```
1. To curl with the access token, do the following (replace with your access
  token):
```
curl -H "Authorization: Bearer a7f7eeb0b70a444c3f755475537bbfd0be5bd49a6fe92bf135d518693372d4af" \
-X GET http://localhost:3000/api/hello
```
Should return:
`{"hello":"world"}`
1. We've now confirmed we having a working access token with a protected
end point. Run `bin/rails s` and navigate to http://localhost:3000/swagger. Add
the access token from above in api_key field. Click explore. Click hello. The
api end point will drop down. Click get and then Try it out! The response will
say you are not authenticated.

![example](screenshot.png)
