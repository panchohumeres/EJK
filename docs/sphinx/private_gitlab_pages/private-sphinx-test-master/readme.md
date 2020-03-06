# Intro
This repo served as a testing ground and now as an example of how one could structure a repo and yaml file to use pipelines from gitlab to deploy gitlab pages automatically. These pages are hidden behind some crude password protection.

https://rmenk.gitlab.io/private-sphinx-test/

## Contributions
Improvements to the password protection by using a different method or what ever would be most welcome (I know very little about this subject, most was copied from various other repos to get this working, A dangerous combination in security research, I know.)

The basic functionallity should reman the same, a sphinx setup that build the docs as normal, and then a yaml file that build sthe docs and makes the arrangments to hide them. 



## Password:
For this example the password is bob.

Rename the folder as described in this repo (use the password.html file to generate the required hash.)
https://github.com/matteobrusa/Password-protection-for-static-pages/blob/master/index.html