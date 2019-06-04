# Assess the strength of your checks tool

Date: 2019-04-25

## Purpose

This tool, potentially the first of several similar, will be used to help assess services'
digital identity needs, for example whether they are meeting the Good Practice Guide 45
identity standard. The aim is to simplify and explain the standard, and make it easier
to use.

The tool would be used by:

 - service owners
 - consulting technical architects
 - technical assessors (i.e. doing service assessments)
 - risk advisors

## Setting up the app in development

```
./build.sh  # create a Docker image
./startup.sh  # run a local server on Docker
```

## Updating dependencies

```
rm Gemfile.lock  # and/or
rm yarn.lock
./build.sh
```

## Running tests
```
./pre-commit.sh
```

## Running arbitrary commands with docker-compose

To drop into a debugger if your `spec` tests fail, you can use:

```
docker-compose run -e PRY_RESCUE_RAILS=true app bin/rake spec
```

## Deploying the app to PaaS

To view the application deployed on PaaS visit the following url [https://isf-assess-the-strength-of-your-check-rails.cloudapps.digital](https://isf-assess-the-strength-of-your-check-rails.cloudapps.digital)

On PaaS the application lives within the organisation `govuk-verify` and inside space `1.docs`

To deploy the application to PaaS you need to login and navigate into the correct organisation and space. From there you simply run:

```
cf push isf-assess-the-strength-of-your-check-rails
```

## Requirements

The tool asks the user a series of questions; some are shown or skipped depending on the
answers previously given. At the end, the tool provides analysis and advice based on
the answers supplied.

As these seem like simple needs, we wanted to make sure we weren't going to be doing
any more development work than required. Ideally, little or no development resource
should be required to maintain the service in future, even if there are changes to the
question or to the analysis rules (ie scoring associated with each answer).

![Activity diagram](docs/assets/images/activity.png)

## Implementation options

We did not consider paid SaaS forms suppliers.

We looked into whether the [Ministry of Justice form builder](https://github.com/ministryofjustice/form-builder)
could allow non-developers to maintain the tool with minimal developer effort.

The MOJ form builder is comprehensive in the components it offers, and is fully
integrated with the GOV.UK Design System. The editor currently runs on Mac OS X
only, the forms run in Node.JS, and we anticpate the 'runner' could be deployed
into the GOV.UK PaaS relatively easily. Question data is stored in JSON format
that can be version controlled eg in Github.

However, we made the folowing observations:

* The editor is very opinionated about exactly how many paragraphs of text are allowed in single-question pages. Wrangling questions into the right format is tricky, even when we're following the design patterns closely. (For example, we had to have a second paragraph of "optional content" moved into the question's "label" on a radio button question, because the label is mandatory, even though we don't have a separate label.
* It wasn't possible to intersperse content between radio button labels, for example putting "Or" before the final "You're not sure" option.
* The 'check your answers' page literally takes the questions and displays the answers given, so…
* You can't do any calculations there (e.g. 'this combination of answers means X vs Y')
* Any abuse of the question labels you had to do (see example above) is problematic, as what displays as a paragraph of text on the question page is used as the row heading: there doesn't seem to be a 'short form' text you can assign to a question.
* We also could not see how to modify the 'Accept and send your application' button – even if the service you've designed isn't really an 'application form' at all.

For this (non-transactional) service, the inability to have a final 'results' page that can be heavily customised based on the users' responses, in addition to the standard 'check your answers' page, is the deciding factor in concluding that the MOJ form builder is not right for this service.

### Commentary

It seems likely that any generic form-building solution (whether SaaS or self-hosted) would
suffer from similar compromises. The more configurable and customisable a solution, the more
its complexity is likely to approach that of building a custom application (in a modern
framework like Rails or Django).

However, should the MOJ Form Builder (or something based upon it) one day evolve to allow
creating forms that mix pre-built components with custom template code, it might
in fact meet the needs of a large number of the more simple submissions-based and
non-transactional services. GOV.UK Notify is a successful example of a platform service
that makes templating available to its users in this way.

## Proposed architecture

We will build a custom Rails application to provide this service.

If we can, we will avoid duplicating template code, by storing question data in a minimal 
format such as YAML or JSON, but we'll use custom templates wherever necessary.

We will deploy the application on the GOV.UK PaaS.

### Consequences

Some developer time will likely be required if substantial changes are made to
the question flow or to the analysis and results pages. If multiple tools are
developed in future, then developer effort might be required to factor out common
features into a library.
