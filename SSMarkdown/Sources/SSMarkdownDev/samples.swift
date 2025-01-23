//
//  samples.swift
//
//
//  Created by Colbyn Wadman on 4/2/24.
//

import Foundation

// MARK: - EXAMPLE 1 -
public let markdownSourceCodeExample1: String = """
# Paragraphs

In Markdown, you can make text *italic* by wrapping it in asterisks (`*`) or underscores (`_`). To make text **bold**, use two asterisks or underscores 1.

For ***bold and italic***, use three asterisks or underscores 2.

You can create a link by wrapping the link text in brackets (`[]`), followed by the URL in parentheses (`()`): [OpenAI](https://www.openai.com) Similarly to links, you can include an image by adding an exclamation mark (`!`), followed by the alt text in brackets, and the image URL in parentheses: ![OpenAI Logo](https://example.com/openai_logo.png)

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

## Lists
Markdown supports ordered and unordered lists.

### Unordered Lists
- Item 1
- Item 2
  - Subitem 2.1
  - Subitem 2.2

### Ordered Lists
1. First item
2. Second item
   1. Subitem 2.1
   2. Subitem 2.2

## Links
You can create a link by wrapping the link text in brackets (`[]`), followed by the URL in parentheses (`()`):

[OpenAI](https://www.openai.com)

## Images
Similarly to links, you can include an image by adding an exclamation mark (`!`), followed by the alt text in brackets, and the image URL in parentheses:

![OpenAI Logo](https://example.com/openai_logo.png)

## Code
You can present code by wrapping it in backticks (`). For inline code, use a single backtick:

`<div class="container">`

For a block of code, use three backticks or indent with four spaces:

## Fenced Code Blocks

```
function main() {}
```

## With Language

```json
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```
"""
// MARK: - EXAMPLE 2 -
public let markdownSourceCodeExample2: String = """
# Complex Markdown File for Testing

This markdown document includes a variety of elements for testing purposes, including standard markdown formatting, embedded HTML, and LaTeX-formatted math equations.

## Table of Contents

- [Introduction](#introduction)
- [Markdown Formatting](#markdown-formatting)
  - [Headings](#headings)
  - [Lists](#lists)
  - [Code](#code)
- [Embedded HTML](#embedded-html)
- [Math Equations](#math-equations)

## Introduction

This document is designed to test the capabilities and compatibility of markdown parsers, especially those that need to handle complex documents with embedded HTML and math equations.

## Markdown Formatting

Markdown provides simple formatting syntax for documents. Here are some examples:

### Headings

```
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
```

### Lists

Unordered list:

- Item 1
- Item 2
  - Subitem 2.1
  - Subitem 2.2

Ordered list:

1. First item
2. Second item
   1. Subitem 2.1
   2. Subitem 2.2

### Code

Inline `code` and block code:

```python
def function():
    print("This is a block of code")
```

## Embedded HTML

Markdown also supports embedded HTML for more complex formatting needs.

<div style="color: red; font-weight: bold;">This is a line of text in red and bold, using HTML.</div>

## Math Equations

For mathematical notations, LaTeX formatting can be embedded within markdown. Here are a few examples:

Inline math: $E = mc^2$

Block math:

$$
x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}
$$

Another block math example:

$$
\\int_0^\\infty e^{-x^2} dx = \\frac{\\sqrt{\\pi}}{2}
$$


# h1 Heading
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

___

---

***


## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,  -- ---

"Smartypants, double quotes" and 'single quotes'


## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes


> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.


## Lists

Unordered

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa


1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar


## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


Block code "fences"

```
Sample text here...
```

Syntax highlighting

``` js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")


## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :cry: :laughing: :yum:
>

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O


==Marked text==


### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

# Markdown: Syntax

*   [Overview](#overview)
    *   [Philosophy](#philosophy)
    *   [Inline HTML](#html)
    *   [Automatic Escaping for Special Characters](#autoescape)
*   [Block Elements](#block)
    *   [Paragraphs and Line Breaks](#p)
    *   [Headers](#header)
    *   [Blockquotes](#blockquote)
    *   [Lists](#list)
    *   [Code Blocks](#precode)
    *   [Horizontal Rules](#hr)
*   [Span Elements](#span)
    *   [Links](#link)
    *   [Emphasis](#em)
    *   [Code](#code)
    *   [Images](#img)
*   [Miscellaneous](#misc)
    *   [Backslash Escapes](#backslash)
    *   [Automatic Links](#autolink)


**Note:** This document is itself written using Markdown; you
can [see the source for it by adding '.text' to the URL](/projects/markdown/syntax.text).

----

## Overview

### Philosophy

Markdown is intended to be as easy-to-read and easy-to-write as is feasible.

Readability, however, is emphasized above all else. A Markdown-formatted
document should be publishable as-is, as plain text, without looking
like it's been marked up with tags or formatting instructions. While
Markdown's syntax has been influenced by several existing text-to-HTML
filters -- including [Setext](http://docutils.sourceforge.net/mirror/setext.html), [atx](http://www.aaronsw.com/2002/atx/), [Textile](http://textism.com/tools/textile/), [reStructuredText](http://docutils.sourceforge.net/rst.html),
[Grutatext](http://www.triptico.com/software/grutatxt.html), and [EtText](http://ettext.taint.org/doc/) -- the single biggest source of
inspiration for Markdown's syntax is the format of plain text email.

## Block Elements

### Paragraphs and Line Breaks

A paragraph is simply one or more consecutive lines of text, separated
by one or more blank lines. (A blank line is any line that looks like a
blank line -- a line containing nothing but spaces or tabs is considered
blank.) Normal paragraphs should not be indented with spaces or tabs.

The implication of the "one or more consecutive lines of text" rule is
that Markdown supports "hard-wrapped" text paragraphs. This differs
significantly from most other text-to-HTML formatters (including Movable
Type's "Convert Line Breaks" option) which translate every line break
character in a paragraph into a `<br />` tag.

When you *do* want to insert a `<br />` break tag using Markdown, you
end a line with two or more spaces, then type return.

### Headers

Markdown supports two styles of headers, [Setext] [1] and [atx] [2].

Optionally, you may "close" atx-style headers. This is purely
cosmetic -- you can use this if you think it looks better. The
closing hashes don't even need to match the number of hashes
used to open the header. (The number of opening hashes
determines the header level.)


### Blockquotes

Markdown uses email-style `>` characters for blockquoting. If you're
familiar with quoting passages of text in an email message, then you
know how to create a blockquote in Markdown. It looks best if you hard
wrap the text and put a `>` before every line:

> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
>
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.

Markdown allows you to be lazy and only put the `>` before the first
line of a hard-wrapped paragraph:

> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.

> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
id sem consectetuer libero luctus adipiscing.

Blockquotes can be nested (i.e. a blockquote-in-a-blockquote) by
adding additional levels of `>`:

> This is the first level of quoting.
>
> > This is nested blockquote.
>
> Back to the first level.

Blockquotes can contain other Markdown elements, including headers, lists,
and code blocks:

> ## This is a header.
>
> 1.   This is the first list item.
> 2.   This is the second list item.
>
> Here's some example code:
>
>     return shell_exec("echo $input | $markdown_script");

Any decent text editor should make email-style quoting easy. For
example, with BBEdit, you can make a selection and choose Increase
Quote Level from the Text menu.


### Lists

Markdown supports ordered (numbered) and unordered (bulleted) lists.

Unordered lists use asterisks, pluses, and hyphens -- interchangeably
-- as list markers:

*   Red
*   Green
*   Blue

is equivalent to:

+   Red
+   Green
+   Blue

and:

-   Red
-   Green
-   Blue

Ordered lists use numbers followed by periods:

1.  Bird
2.  McHale
3.  Parish

It's important to note that the actual numbers you use to mark the
list have no effect on the HTML output Markdown produces. The HTML
Markdown produces from the above list is:

If you instead wrote the list in Markdown like this:

1.  Bird
1.  McHale
1.  Parish

or even:

3. Bird
1. McHale
8. Parish

you'd get the exact same HTML output. The point is, if you want to,
you can use ordinal numbers in your ordered Markdown lists, so that
the numbers in your source match the numbers in your published HTML.
But if you want to be lazy, you don't have to.

To make lists look nice, you can wrap items with hanging indents:

*   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
    viverra nec, fringilla in, laoreet vitae, risus.
*   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
    Suspendisse id sem consectetuer libero luctus adipiscing.

But if you want to be lazy, you don't have to:

*   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
viverra nec, fringilla in, laoreet vitae, risus.
*   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
Suspendisse id sem consectetuer libero luctus adipiscing.

List items may consist of multiple paragraphs. Each subsequent
paragraph in a list item must be indented by either 4 spaces
or one tab:

1.  This is a list item with two paragraphs. Lorem ipsum dolor
    sit amet, consectetuer adipiscing elit. Aliquam hendrerit
    mi posuere lectus.

    Vestibulum enim wisi, viverra nec, fringilla in, laoreet
    vitae, risus. Donec sit amet nisl. Aliquam semper ipsum
    sit amet velit.

2.  Suspendisse id sem consectetuer libero luctus adipiscing.

It looks nice if you indent every line of the subsequent
paragraphs, but here again, Markdown will allow you to be
lazy:

*   This is a list item with two paragraphs.

    This is the second paragraph in the list item. You're
only required to indent the first line. Lorem ipsum dolor
sit amet, consectetuer adipiscing elit.

*   Another item in the same list.

To put a blockquote within a list item, the blockquote's `>`
delimiters need to be indented:

*   A list item with a blockquote:

    > This is a blockquote
    > inside a list item.

To put a code block within a list item, the code block needs
to be indented *twice* -- 8 spaces or two tabs:

*   A list item with a code block:

        function main() { /* ... */ }

### Code Blocks

Pre-formatted code blocks are used for writing about programming or
markup source code. Rather than forming normal paragraphs, the lines
of a code block are interpreted literally. Markdown wraps a code block
in both `<pre>` and `<code>` tags.

To produce a code block in Markdown, simply indent every line of the
block by at least 4 spaces or 1 tab.

This is a normal paragraph:

    This is a code block.

Here is an example of AppleScript:

    tell application "Foo"
        beep
    end tell

A code block continues until it reaches a line that is not indented
(or the end of the article).

Within a code block, ampersands (`&`) and angle brackets (`<` and `>`)
are automatically converted into HTML entities. This makes it very
easy to include example HTML source code using Markdown -- just paste
it and indent it, and Markdown will handle the hassle of encoding the
ampersands and angle brackets. For example, this:

    <div class="footer">
        &copy; 2004 Foo Corporation
    </div>

Regular Markdown syntax is not processed within code blocks. E.g.,
asterisks are just literal asterisks within a code block. This means
it's also easy to use Markdown to write about Markdown's own syntax.

```
tell application "Foo"
    beep
end tell
```

## Span Elements

### Links

Markdown supports two style of links: *inline* and *reference*.

In both styles, the link text is delimited by [square brackets].

To create an inline link, use a set of regular parentheses immediately
after the link text's closing square bracket. Inside the parentheses,
put the URL where you want the link to point, along with an *optional*
title for the link, surrounded in quotes. For example:

This is [an example](http://example.com/) inline link.

[This link](http://example.net/) has no title attribute.

### Emphasis

Markdown treats asterisks (`*`) and underscores (`_`) as indicators of
emphasis. Text wrapped with one `*` or `_` will be wrapped with an
HTML `<em>` tag; double `*`'s or `_`'s will be wrapped with an HTML
`<strong>` tag. E.g., this input:

*single asterisks*

_single underscores_

**double asterisks**

__double underscores__

### Code

To indicate a span of code, wrap it with backtick quotes (`` ` ``).
Unlike a pre-formatted code block, a code span indicates code within a
normal paragraph. For example:

Use the `printf()` function.
"""
// MARK: - EXAMPLE 3 -
let markdownSourceCodeExample3: String = """
- List item text
    - Nested list item
        - Further nested list item

          ```
          This code block is part of the "further nested list item."
          ```
- Here
    This is a code block inside a list item.
"""
// MARK: - EXAMPLE 4 -
let markdownSourceCodeExample4 = """

# Nested Markdown Example

This document showcases various Markdown nesting capabilities.


## Inline Elements

- Text with `inline code`, **bold**, *italic*, ~~strikethrough~~, and [a link](https://example.com).
  - Sublist with ![Image Alt](https://example.com/image.jpg)


## Lists within Lists

- First level item
  - Second level item
    - Third level item with **bold** text
      - Fourth level item with a link: [OpenAI](https://www.openai.com)
    - Back to the third level with an image: ![Alt text](https://example.com/image.jpg)
  - Second level continues
    ```
    Code block nested within a list.
    ```

## Blockquotes within Lists

- List item with a blockquote:
  > This is a blockquote
  >
  > Nested within a list item.
  - Sublist item under a blockquote
    > Another blockquote inside a sublist

## Lists within Blockquotes

> - First level list inside a blockquote
>   - Second level list
> - First level continues
>
> More text in the blockquote.

## Code Blocks within Blockquotes

> ```
> Code block inside a blockquote.
> ```
>
> More text in the blockquote.

## Nested Blockquotes

> First level of blockquote.
>
> > Second level of blockquote with **bold** text.
> >
> > - List inside a nested blockquote
> >   - Sub-item with *italic* text
>
> Back to first level of blockquote.

## Complex Nesting

- List item
  > Blockquote with a list
  > - First level list
  >   > Nested blockquote
  >   >
  >   > More text in the nested blockquote
  >   > - List inside nested blockquote
  >   >   ```
  >   >   Code block inside a nested blockquote within a list.
  >   >   ```
  >   - Second level list item with `inline code`
  >
  > Back to the blockquote within the list
  ```
  Code block after a blockquote in a list.
  ```
"""
// MARK: - EXAMPLE 5 -
let markdownSourceCodeExample5 = """
# Nested Markdown Example with Headlines and Paragraphs

This document showcases various Markdown nesting capabilities, including headlines and paragraphs.

## Lists within Lists

- A: First level item
  - A.1 level item with a paragraph below:
  
    This is a paragraph within a list item, demonstrating how text can be structured within lists.

    - A.1.1 Third level item with **bold** text and a following headline:
    
      ### Nested Headline
        
      After a nested list item, demonstrating headlines within list contexts. Note that the headline is not technically "inside" the list in Markdown's syntax but serves to organize content related to the list.

      - Fourth level item with a link: [OpenAI](https://www.openai.com)
- B: Second level item
  - B.1 level item with a paragraph below:
  
    This is a paragraph within a list item, demonstrating how text can be structured within lists.
    ```
    function main() {}
    ```

## Blockquotes within Lists

- List item with a blockquote:
  > This is a blockquote
  >
  > Nested within a list item.
  >
  > After the blockquote, a new paragraph within the same list item can provide further explanation or context.

## Lists within Blockquotes

> Here's a headline within a blockquote:
>
> ## Blockquoted Headline
>
> - First level list inside a blockquote
>   - Second level list
>
> Continuing text in the blockquote after a list. This demonstrates how paragraphs and lists can be mixed within a blockquote.

## Nested Blockquotes with Headlines

> First level of blockquote.
>
> > ## Second Level Headline
> >
> > Second level of blockquote with **bold** text.
> >
> > - List inside a nested blockquote
> >   - Sub-item with *italic* text

## Complex Nesting with Paragraphs and Headlines

- List item with a headline below:
  
  ### List Item Headline
  
  This is a paragraph after a headline, which follows a list item. The structure here shows how various elements can be sequenced for clarity and organization.

  > Blockquote with a list
  > - First level list
  >   - Second level list item with a paragraph inside a blockquote:
  >
  >     This paragraph is within a blockquote, showing how text can be formatted in complex nested scenarios.

## Inline Elements in Paragraphs

This paragraph includes `inline code`, **bold**, *italic*, ~~strikethrough~~, and [a link](https://example.com). Inline elements can enrich the text, providing emphasis and links where needed.

- List following a paragraph to demonstrate transition from standard text to a list.

## Some Lists

### Variant One

- Boil water in a kettle.
  - Use filtered water for a better taste.
- Place a tea bag in your cup.
  - Green tea for a lighter flavor.
  - Black tea for a stronger flavor.
- Pour boiling water into the cup.
- Let the tea steep for 3-5 minutes.
  - 3 minutes for a lighter taste.
  - 5 minutes for a stronger brew.
- Enjoy your tea.
  - Add honey or lemon if desired.

### Variant Two

1. Boil water in a kettle.
    - Use filtered water for a better taste.
2. Place a tea bag in your cup.
    - Green tea for a lighter flavor.
    - Black tea for a stronger flavor.
3. Pour boiling water into the cup.
4. Let the tea steep for 3-5 minutes.
    - 3 minutes for a lighter taste.
    - 5 minutes for a stronger brew.
5. Enjoy your tea.
    - Add honey or lemon if desired.
"""
// MARK: - EXAMPLE 6 -
let markdownSourceCodeExample6 = """
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Row 1.A    | Data     | Example  |
| Row 2.B    | Data     | Example  |

Name    | Age | City
------- | --- | ----------
John Doe| 29  | San Francisco
Jane Doe| 32  | New York

Product  | Price | Quantity
:--------| -----:|:--------:
Apple    |    $1 | 100
Banana   |   $.5 | 500

Feature   | Supported | Details
----------|:---------:| -------
Markdown  | YES       | Basic syntax only
Tables    | PARTIAL   | Without outer pipes
Footnotes | NO        |

Author        | Work          | Year
--------------|---------------| ----
Shakespeare   | Hamlet        | 1600
Fitzgerald    | Great Gatsby  | 1925
Orwell        | 1984          | 1949


Main Category | Sub-category | Details
--------------|--------------| -------
Fruit         | Apple        | Green
              | Banana       | Yellow
Vegetables    | Carrot       | Orange
              | Lettuce      | Green

Title  | Description
------ | -----------
Item 1 | This is a longer description that spans more text.
Item 2
Item 3 | Description | Extra column

Item      | Description    | Price
--------- | -------------- | ------
Pen       | Blue ink       | $1.25
Notebook  | 100 pages      | $2.50

First Name | Last Name | Email Address
-----------|-----------|--------------
"""


let basicMarkdownBlocksExample1 = """
- Boil water in a kettle.
  - Use filtered water for a better taste.

 - Place a tea bag in your cup.
  - Green tea for a lighter flavor.
  - Black tea for a stronger flavor.
- Pour boiling water into the cup.
- Let the tea steep for 3-5 minutes.
  - 3 minutes for a lighter taste.
  - 5 minutes for a stronger brew.
- Enjoy your tea.
  - Add honey or lemon if desired.
"""
let basicMarkdownBlocksExample2 = """
1. Boil water in a kettle.
    - Use filtered water for a better taste.
2. Place a tea bag in your cup.
    - Green tea for a lighter flavor.
    - Black tea for a stronger flavor.
3. Pour boiling water into the cup.
4. Let the tea steep for 3-5 minutes.
    - 3 minutes for a lighter taste.
    - 5 minutes for a stronger brew.
5. Enjoy your tea.
    - Add honey or lemon if desired.
"""
let basicMarkdownBlocksExample3 = """
- AAA
  - A1
    > 1 Hello World
    > 2 Hello World
  - A2
  - A3
- BBB
    - B1
    - B2
    - B3
- CCC
    - C1
    - C2
    - C3
1. 111
    1. a
    1. a
    1. a
2. 222
    - 2.1
    - 2.2
    - 2.3
3. 333
    - 3.1
    - 3.2
    - 3.3
"""

let allSourceSamples: [ String ] = [
    markdownSourceCodeExample1,
    markdownSourceCodeExample2,
    markdownSourceCodeExample3,
    markdownSourceCodeExample4,
    markdownSourceCodeExample5,
    markdownSourceCodeExample6,
    basicMarkdownBlocksExample1,
    basicMarkdownBlocksExample2,
    basicMarkdownBlocksExample3,
]
