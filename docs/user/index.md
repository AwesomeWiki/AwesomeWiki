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

<table>
    <tr>
        <th>
            Path
        </th>
        <th>
            Description
        </th>
        <th>
            Example Response
        </th>
    </tr>
    <tr>
        <td>
            /languages
        </td>
        <td>
            Returns the list of languages supported.
        </td>
        <td>
            <pre lang="json">
                [
                 {
                  name: "JavaScript",
                  slug: "javascript"
                 },
                 {
                  name: "Python",
                  slug: "python"
                 },
                 { ... },
                 ...
                ]
            </pre>
        </td>
    </tr>
    <tr>
        <td>
            /:lang/categories
        </td>
        <td>
            Returns the categories for a language, identified by that language’s slug.
        </td>
        <td>
            <pre lang="json">
            </pre>
        </td>
    </tr>
    <tr>
        <td>
            /:lang/:cat
        </td>
        <td>
            Returns the libraries for a particular language and category, identified by their slugs.
        </td>
        <td>
            <pre lang="json">
            </pre>
        </td>
    </tr>
    <tr>
        <td>
            /:lang/:fqn
        </td>
        <td>
            Returns the information about a single library, based on it’s Fully Qualified Name (FQN).
        </td>
        <td>
            <pre lang="json">
            </pre>
        </td>
    </tr>
    <tr>
        <td>
            /:lang/:fqn/articles
        </td>
        <td>
            Returns a list of articles for a library based on it’s Fully Qualified Name (FQN).
        </td>
        <td>
            <pre lang="json">
            </pre>
        </td>
    </tr>
</table>

