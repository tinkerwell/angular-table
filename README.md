# angular-table

Lets you declare sortable, pageable tables with minimal effort while providing high flexibilty.

Written in CoffeeScript.

[Examples](http://ssmm.github.io/angular-table/examples.html)

## How

### Rendering cells: implicit or custom

```html
  <!-- list references the list in scope you would like to render -->
  <table at-table list="list">
    <!-- dont declare the thead tag if you don't want to render a header -->
    <thead></thead>
    <tbody>
      <tr>
        <!-- use at-implicit to automatically render the attribute of each item in the list -->
        <td at-implicit attribute="id"></td>
        <!-- declare a custom title for a column -->
        <td at-implicit attribute="description" title="the description"></td>
        <!-- render custom output and declare a title -->
        <td title="name">
          The name is {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>
```

Result:

<table>
  <thead>
    <tr>
      <th>Id</th>
      <th>The Description</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>description 1</td>
      <td>The name is name 1</td>
    </tr>
    <tr>
      <td>2</td>
      <td>description 2</td>
      <td>The name is name 2</td>
    </tr>
    <tr>
      <td>3</td>
      <td>description 3</td>
      <td>The name is name 3</td>
    </tr>
  </tbody>
</table>

### Enable sorting for any column

```html
  <table at-table class="table" list="list">
    <thead></thead>
    <tbody>
      <tr>
        <!-- declare a column to be sortable -->
        <td sortable at-implicit attribute="id"></td>
        <!-- sorting will not be available for this column -->
        <td at-implicit attribute="description" title="the description"></td>
        <!-- declare an attribute to sort by -->
        <td sortable title="name" attribute="name">
          The name is {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>
```

Instead of declaring an empty `sortable` attribute, you can also use `class="sortable"`. This becomes
especially useful when using haml, where you can simply write:

```haml
  %td.sortable(at-implicit attribute="id")
```

### Add pagination

```html
  <!-- reference the pagination defined below -->
  <table at-table class="table" list="list" pagination="pagination">
    <thead></thead>
    <tbody>
      <tr>
        <td sortable at-implicit attribute="id"></td>
        <td sortable at-implicit attribute="description" title="the description"></td>
        <td title="name">
          The name is {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>
  <!--
    Define the name of this pagers instance in the scope.
    The pagination must have a reference to the rendered list so it can update itself
    when there are items added to or removed from the list.
  -->
  <at-pagination items-per-page="5" instance="pagination" list="list" />

```

### Declaring widths

The common ways for declaring widths work as expected: you can use colgroup, css or the `width` attribute.
Besides that, you can also use `class="200px"`. This becomes especially useful when using haml, where you can
simply write:

```haml
  %td.200px(at-implicit attribute="id")
```

### Customizing the header

Simply provide custom `th` elements. You must declare `attribute` to address the specific column:

```html
  <thead>
    <tr>
      <th attribute="description">
        <i class="icon-info-sign"></i> Header with icon
      </th>
    </tr>
  </thead>
```

### Filtering

This directive does not attempt to provide a mechanism for filtering. You can of course filter
the list yourself. This will be reflected automatically by the table and the pagination, since
we have a bi-directional binding.
