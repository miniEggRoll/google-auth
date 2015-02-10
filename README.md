# google-auth
Token exchange through google oauth. 
It takes the hd of the token for authentication.

# how to use
Send POST request with body

- googleAccessToken: access token from google oauth login

Token is then returned according to request origin and registered logic, as is described in src/origin.

# todo 
- More token provider
