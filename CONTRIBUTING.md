# Contributing to Invadorz

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing [Organization](https://michaelrobertlyons.com/) on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

#### Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [Atom and Packages](#atom-and-packages)
  * [Atom Design Decisions](#design-decisions)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Enhancements](#suggesting-enhancements)
  * [Your First Code Contribution](#your-first-code-contribution)
  * [Pull Requests](#pull-requests)

[Styleguides](#styleguides)
  * [Git Commit Messages](#git-commit-messages)
  * [JavaScript Styleguide](#javascript-styleguide)
  * [CoffeeScript Styleguide](#coffeescript-styleguide)
  * [Specs Styleguide](#specs-styleguide)
  * [Documentation Styleguide](#documentation-styleguide)

[Additional Notes](#additional-notes)
  * [Issue and Pull Request Labels](#issue-and-pull-request-labels)

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [lyons.mr@gmail.com](mailto:lyons.mr@gmail.com).

## I don't want to read this whole thing I just have a question!!!

> **Note:** [Please don't file an issue to ask a question.](https://blog.atom.io/2016/04/19/managing-the-deluge-of-atom-issues.html) You'll get faster results by using the resources below.

<!-- We have an official message board with a detailed FAQ and where the community chimes in with helpful advice if you have questions.

* [Github Discussions, the official message board](https://github.com/atom/atom/discussions)
* [Atom FAQ](https://flight-manual.atom.io/faq/) -->

## What should I know before I get started?

<a id="atom-packages-image"/>

![atom-packages](https://cloud.githubusercontent.com/assets/69169/10472281/84fc9792-71d3-11e5-9fd1-19da717df079.png)

#### Package Conventions

There are a few conventions that have developed over time around packages:

* Packages that add one or more syntax highlighting grammars are named `language-[language-name]`
    * Language packages can add other things besides just a grammar. Many offer commonly-used snippets. Try not to add too much though.
* Theme packages are split into two categories: UI and Syntax themes
    * UI themes are named `[theme-name]-ui`
    * Syntax themes are named `[theme-name]-syntax`
    * Often themes that are designed to work together are given the same root name, for example: `one-dark-ui` and `one-dark-syntax`
    * UI themes style everything outside of the editor pane &mdash; all of the green areas in the [packages image above](#atom-packages-image)
    * Syntax themes style just the items inside the editor pane, mostly syntax highlighting
* Packages that add [autocomplete providers](https://github.com/atom/autocomplete-plus/wiki/Autocomplete-Providers) are named `autocomplete-[what-they-autocomplete]` &mdash; ex: [autocomplete-css](https://github.com/atom/autocomplete-css)

### Design Decisions

When we make a significant decision in how we maintain the project and what we can or cannot support, we will document it in the **How Can I Contribute?**

### Reporting Bugs

This section guides you through submitting a bug report for Atom. Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

Provide more context by answering these questions: ?
Include details about your configuration and environment:

**Which keyboard layout are you using?** Are you using a US layout or some other layout?

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion , including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

#### Before Submitting An Enhancement Suggestion

#### How Do I Submit A (Good) Enhancement Suggestion?

### Your First Code Contribution

Unsure where to begin contributing to Atom? You can start by looking through these `beginner` and `help-wanted` issues:

* [Beginner issues][beginner] - issues which should only require a few lines of code, and a test or two.
* [Help wanted issues][help-wanted] - issues which should be a bit more involved than `beginner` issues.

Both issue lists are sorted by total number of comments. While not perfect, number of comments is a reasonable proxy for impact a given change will have.

#### Local development

### Pull Requests

The process described here has several goals:

- Maintain quality
- Fix problems that are important to users
- Engage the community in working toward the best possible
- Enable a sustainable system for maintainers to review contributions

Please follow these steps to have your contribution considered by the maintainers:

1. Follow all instructions in [the template](PULL_REQUEST_TEMPLATE.md)
2. Follow the [styleguides](#styleguides)
3. After you submit your pull request, verify that all [status checks](https://help.github.com/articles/about-status-checks/) are passing <details><summary>What if the status checks are failing?</summary>If a status check is failing, and you believe that the failure is unrelated to your change, please leave a comment on the pull request explaining why you believe the failure is unrelated. A maintainer will re-run the status check for you. If we conclude that the failure was a false positive, then we will open an issue to track that problem with our status check suite.</details>

While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.

## Styleguides

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line
* When only changing documentation, include `[ci skip]` in the commit title
* Consider starting the commit message with an applicable emoji:
    * :art: `:art:` when improving the format/structure of the code
    * :racehorse: `:racehorse:` when improving performance
    * :non-potable_water: `:non-potable_water:` when plugging memory leaks
    * :memo: `:memo:` when writing docs
    * :penguin: `:penguin:` when fixing something on Linux
    * :apple: `:apple:` when fixing something on macOS
    * :checkered_flag: `:checkered_flag:` when fixing something on Windows
    * :bug: `:bug:` when fixing a bug
    * :fire: `:fire:` when removing code or files
    * :green_heart: `:green_heart:` when fixing the CI build
    * :white_check_mark: `:white_check_mark:` when adding tests
    * :lock: `:lock:` when dealing with security
    * :arrow_up: `:arrow_up:` when upgrading dependencies
    * :arrow_down: `:arrow_down:` when downgrading dependencies
    * :shirt: `:shirt:` when removing linter warnings

### JavaScript Styleguide

All JavaScript code is linted with [Prettier](https://prettier.io/).

* Prefer the object spread operator (`{...anotherObj}`) to `Object.assign()`
* Inline `export`s with expressions whenever possible
  ```js
  // Use this:
  export default class ClassName {

  }

  // Instead of:
  class ClassName {

  }
  export default ClassName
  ```
* Place requires in the following order:
    * Built in Node Modules (such as `path`)
    * Built in Electron Modules (such as `atom`, `remote`)
    * Local Modules (using relative paths)
* Place class properties in the following order:
    * Class methods and properties (methods starting with `static`)
    * Instance methods and properties

### CoffeeScript Styleguide

* Set parameter defaults without spaces around the equal sign
    * `clear = (count=1) ->` instead of `clear = (count = 1) ->`
* Use spaces around operators
    * `count + 1` instead of `count+1`
* Use spaces after commas (unless separated by newlines)
* Use parentheses if it improves code clarity.
* Prefer alphabetic keywords to symbolic keywords:
    * `a is b` instead of `a == b`
* Avoid spaces inside the curly-braces of hash literals:
    * `{a: 1, b: 2}` instead of `{ a: 1, b: 2 }`
* Include a single line of whitespace between methods.
* Capitalize initialisms and acronyms in names, except for the first word, which
  should be lower-case:
  * `getURI` instead of `getUri`
  * `uriToOpen` instead of `URIToOpen`
* Use `slice()` to copy an array
* Add an explicit `return` when your function ends with a `for`/`while` loop and
  you don't want it to return a collected array.
* Use `this` instead of a standalone `@`
  * `return this` instead of `return @`
* Place requires in the following order:
    * Built in Node Modules (such as `path`)
    * Local Modules (using relative paths)
* Place class properties in the following order:
    * Class methods and properties (methods starting with a `@`)
    * Instance methods and properties

### Specs Styleguide

- Include thoughtfully-worded, well-structured [Jasmine](https://jasmine.github.io/) specs in the `./spec` folder.
- Treat `describe` as a noun or situation.
- Treat `it` as a statement about state or how an operation changes state.

#### Example

```coffee
describe 'a dog', ->
 it 'barks', ->
 # spec here
 describe 'when the dog is happy', ->
  it 'wags its tail', ->
  # spec here
```

### Documentation Styleguide

* Use [Markdown](https://daringfireball.net/projects/markdown).
* Reference methods and classes in markdown with the custom `{}` notation:
    * Reference classes with `{ClassName}`
    * Reference instance methods with `{ClassName::methodName}`
    * Reference class methods with `{ClassName.methodName}`

#### Example

```coffee
# Public: Disable the package with the given name.
#
# * `name`    The {String} name of the package to disable.
# * `options` (optional) The {Object} with disable options (default: {}):
#   * `trackTime`     A {Boolean}, `true` to track the amount of time taken.
#   * `ignoreErrors`  A {Boolean}, `true` to catch and ignore errors thrown.
# * `callback` The {Function} to call after the package has been disabled.
#
# Returns `undefined`.
disablePackage: (name, options, callback) ->
```

## Additional Notes

### Issue and Pull Request Labels

This section lists the labels we use to help us track and manage issues and pull requests. Most labels are used across all repositories, but some are specific.

The labels are loosely grouped by their purpose, but it's not required that every issue has a label from every group or that an issue can't have more than one label from the same group.

#### Type of Issue and Issue State

#### Topic Categories

#### Pull Request Labels
