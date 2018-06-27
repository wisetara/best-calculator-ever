# README

TODO (if I were to TODO): Add clear functionality--either at submit or via a separate button.

I considered doing a migration and making this a db-storing app, but that seemed like more
than one might want in a calculator.

## Instructions

Please create a rails app in any rails/ruby version.  Don't spend more then 2 hours (really).
Submit either by commit to github, bitbucket, or zipping up your git repo and emailing it to [redacted].


Create a rails app that has one root page that is a calculator.

It implements these operators (say +, -, /,*) on any number of integer arguments.
The page has only a text box and a submit button.
The requested operation and its result should be displayed below the text box after clicking the calculate button. Please avoid using a gem for the calculation portion of the assignment and craft your own calculator mechanism (hint eval is not your friend).

We don't care about UI/UX.
Please write up any tests you think might be important.

Input example:
`5*3+1+6/2+9*100`

Expected output:
`5*3+1+6/2+9*100`
`919`

Input example:
`5*3+1+6/85+9*100`

Expected output:
`5*3+1+6/85+9*100`
`916.07`
