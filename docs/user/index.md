TODO:
-Format json code blocks
-Replace magic quotes with regular quotes ""
-Add screenshots/usability info for client app

# AwesomeWiki User Guide

This guide shows how to use **AwesomeWiki Core** for users who wish to create their own applications that utilize **AwesomeWiki** services.
Topics discussed in this guide include:
-   Use cases
-   AwesomeWiki API

## Use Cases

The goal of AwesomeWiki was to provide aggregation services to Awesome List content while still retaining the ability to have community curation.
Currently, AwesomeWiki is limited to only gathering data on software libraries for Python and Javascript. Some example use cases for this data include:

-   Filtering software libraries based on a particular problem that a user would like to solve
-   Aggregating tutorials on a given software library

## API

AwesomeWiki core provides several API endpoints for getting information about supported languages, library categories, libraries, library details and tutorials/articles.

| Path | Description | Example Response |
|------|-------------|------------------|
|/languages|Returns the list of languages supported.|[<br>&nbsp;{<br>&nbsp; name: “JavaScript”, <br>&nbsp; slug: “javascript”<br>&nbsp;},<br>&nbsp;{<br>&nbsp; name: “Python”, <br>&nbsp; slug: “python”<br>&nbsp;},<br>&nbsp;{ ... },<br>&nbsp;...<br>]|
|/:lang/categories|Returns the categories for a language, identified by that language’s slug.|[<br>&nbsp;{<br>&nbsp; name: “Admin Panels”, <br>&nbsp; slug: “admin-panels”<br>&nbsp;},<br>&nbsp;{<br>&nbsp; name: “Audio”, <br>&nbsp; slug: “audio”<br>&nbsp;},<br>&nbsp;{ ... },<br>&nbsp;...<br>]|
|/:lang/:cat|Returns the libraries for a particular language and category, identified by their slugs.|[<br>&nbsp;{<br>&nbsp; name: “Pandas”, <br>&nbsp; fqn: “pandas”, <br>&nbsp; url: "pandas.pydata.org”<br>&nbsp;},<br>&nbsp;{ ... },<br>&nbsp;...<br>]|
|/:lang/:fqn|Returns the information about a single library, based on it’s Fully Qualified Name (FQN).|{<br>&nbsp; name: “Pandas”,<br>&nbsp; fqn: “pandas”,<br>&nbsp; url: “pandas.pydata.org”, <br>&nbsp; info: { ... }<br>}|
|/:lang/:fqn/articles|Returns a list of articles for a library based on it’s Fully Qualified Name (FQN).|[<br>&nbsp; {<br>&nbsp; title: “A Gentle Visual Intro to Data Analysis in Python Using Pandas”,<br>&nbsp; url: “https://jalammar.github.io/gentle-visual-intro-to-data-analysis-python-pandas/”<br>&nbsp; },<br>&nbsp; { ... },<br>&nbsp; ...<br>&nbsp;]|


