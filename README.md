DC Code XML
===========

This repository contains the Code of the District of Columbia in XML format.

Besides browsing the raw XML, you can also see a [quick preview in HTML](http://joshdata.github.io/dc-code-prototype/index.xml).

The DC Code in XML makes use of a custom schema that draws on ideas from [Akoma Ntoso](http://www.akomantoso.org/) and [United States Legislative Markup](http://uscodebeta.house.gov/download/download.shtml).

The schema can almost entirely be seen in the following four examples.

(1) Root element. The root element is `<dc-code>` and it contains some metadata.

	<dc-code>
		<meta>
			<title>Code of the District of Columbia</title>
			<recency>current through DC Act 19-658; unofficial through D.C. Act 19-682</recency>
		</meta>

		<!-- <level> elements as shown below -->

	</dc-code>

(2) "Big" levels (titles, chapters, and so on)

    <level>
		<type>Title</type>
		<num>1</num>
		<heading>Government Organization</heading>

		<!-- other <level> elements nested here -->

    </level>

(3) Sections and annotations

	<level>
		<type>Section</type>
		<num>2-531</num>
		<heading>Public policy.</heading>

		<text>The public policy of the District of Columbia is that all persons are entitled
		to full and complete information regarding the affairs of government and the official
		acts of those who represent them as public officials and employees. To that end,
		provisions of this subchapter shall be construed with the view toward expansion of public
		access and the minimization of costs and time delays to persons requesting information.</text>

		<level>
		  <type>annotations</type>
		  <level>
		    <heading>History</heading>
		    <text>(Oct. 21, 1968, Pub. L. 90-614, title II, ...</text>
		  </level>
		</level>
	</level>

(4) Little levels

	<level>
		<num>(c)</num>
		<heading>United States</heading>

		<text>The United States, its officers, employees, and agents, and its agencies shall not:</text>

		<level>
			<num>(1)</num>
			<text>Be responsible for the payment of any judgments, liabilities or costs resulting
			from any action or proceeding against the District of Columbia or its agencies,
			officers, employees, or agents;</text>
		</level>

		<!-- other <level> elements nested here -->
	</level>

XInclude
--------

We distribute the DC Code XML in two formats.

1. One large, 73 MB XML file.
2. A collection of smaller XML files that are linked together through XInclude.

This documentation assumes you are working with the one-big-file format.

In the second format, any `<level>` element above the level of a section may be replaced by an XInclude reference to another file containing the element. In this format the top-level file contains:

	<dc-code>
	  <meta>
	    <title>Code of the District of Columbia</title>
	    <recency>current through DC Act 19-658; unofficial through D.C. Act 19-682</recency>
	  </meta>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-I/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-II/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-III/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-IV/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-V/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-VI/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-VII/index.xml"/>
	  <ns0:include xmlns:ns0="http://www.w3.org/2001/XInclude" href="Division-VIII/index.xml"/>
	</dc-code>

Sections never contain XInclude includes.

Root Element and Metadata
-------------------------

The root element is `<dc-code>`. We are not using namespaces.

The root element contains a `<meta>` element with document metadata. The `<meta>` element is followed by `<level>` elements representing the Divisions of the Code.

	<?xml version='1.0' encoding='utf-8'?>
	<dc-code>
	  <meta>
	    <title>Code of the District of Columbia</title>
	    <recency>current through DC Act 19-658; unofficial through D.C. Act 19-682</recency>
	  </meta>
	  <level>
	    <type>Division</type>
	    <num>I</num>
	    <heading>Government of District</heading>
	    <level>
	      <type>Title</type>
	      <num>1</num>
	      <heading>Government Organization</heading>
	      <level>
	        <type>Chapter</type>
	        <num>1</num>
	        <heading>District of Columbia Government Development</heading>
	        <level>
	          <type>Subchapter</type>
	          <num>I</num>
	          <heading>District of Columbia Establishment</heading>
	          <level>
	            <type>Section</type>
	            <num>1-101</num>
	            <heading>Territorial area.</heading>
	            <text>The District of Columbia is that portion of the territory
	            of the United States ceded by the State of Maryland for the permanent
	            seat of government of the United States....

Levels
------

All hierarchy of the Code is represented by `<level>` elements. This includes both "big" levels (titles, chapters, etc.), sections, and "little" levels (subsections, paragraphs, and so on).

A `<level>` contains any of the following subelements:

* `<type>`: The text in this element indicates the type of the level.
 * Possible values for "big" levels include: `Article`, `Chapter`, `Division`, `Part`, `Subchapter`, `Subdivision`, `Subpart`, `Subtitle`, `Title`, and `Unit`.
 * The type can also be `Section` for sections of the code (e.g. § 1-101).
 * The type can also be `annotations` for annotation blocks and `appendices` for a block of appendices to a section (typically but not always within `Section`-levels)
 * When `<type>` is omitted, the level is a numbered paragraph (i.e. `(1) The public policy....`) or an unnumbered block with a heading. Inside annotations, subheadings are represented this way.

* `<num>`: The level's number. 
 * For "big" levels, this usually is a number, letter, or roman numeral.
 * For sections, the number is typically (but not always) in the format `1-101`. It never includes the §-symbol.
 * For "little" levels, this is the paragraph's numbering including any parenthesis around the numbering. An example would be `(12A-i)`.
 * When `<num>` is omitted, the level is simply unnumbered.

* `<heading>`: The level's name or heading.
 * For "big" levels, sections, and subheadings in annotations, this is the name of the level, such as `Government Organization`.
 * A heading can also appear on "little" levels.

Following these elements, `<text>` elements, other nested `<level>` elements, and `<placeholder>` elements can all appear and should be rendered in document order. When rendering "little" levels, nested `<level>` elements should be indented.

Text
----

Text content is contained within `<text>` elements inside `<level>`s. `<text>` may be interleaved with other `<text>` and `<level>` elements and should be rendered in document order. These elements contain HTML, e.g.:

	<text>One <span style="font-style: italic; ">ex officio </span>Commissioner,
	the Deputy Mayor for Planning and Economic Development;</text>

An optional `class` attribute can be one of `form`, `formc`, `table`, `tablec`, and `PlainText`. These are often rendered as monospace, pre-formmated plain text.

Inside the `<text>` element is HTML conforming to the following restrictions:

* Only bare text and `<span>` elements may appear.
* `<span>` elements may have a style attribute containing any of the following CSS:
 * `font-weight: bold;`
 * `font-style: italic;`
 * `text-decoration: underline;`
 * `font-family: monospace;`

Placeholders
------------

`<placeholder>` is similar to `<level>` but represents Code sections that no longer exist or may exist in the future but do not exist now. Here is an example:

    <placeholder>
      <type>Not funded</type>
      <section>1-136.01</section>
      <heading>Establishment of the 51st State Commission.</heading>

      <text>[Not funded].</text>

      <level>
        <type>annotations</type>
        ...
      </level>
    </placeholder>


A `<placeholder>` contains any of the following subelements:

* `<type>`: The reason for the placeholder.
 * When present, one of `Expired`, `Not funded`, `Omitted`, `Repealed`, `Reserved`, and `Transferred`.
 * When not present, the reason for the placeholder is not indicated in the code.
* `<section>`: The number of the omitted section (e.g. `1-136.01`).
* `<heading>`: The name of the omitted section.

In place of `<section>`, a placeholder may instead contain:

* `<section-start>`: The number of the first omitted section in a range of omitted sections.
* `<section-end>`: The number of the last omitted section in a range of omitted sections.
* `<section-range-type>`: This element contains the text `range` if all sections between start and end are omitted (usually rendered as "A to B") or `list` if the start and end name two sections but a range is not implied (usually rendered as "A, B").

Like `<level>`s, a `<placeholder>` may also contain `<text>` and nested `<level>`s. Most placeholders do not contain any text or nested levels, however.
