# angular-table

Lets you declare tables with very little code. Enables sorting and pagination if required.

## Examples

### No sorting, no pagination

```html
  <table at-table list="list"> <!-- list references the list in scope you would like to render -->
    <thead></thead>
    <tbody>
      <tr>
        <!-- use at-implicit to automatically render an attribute of each item in list -->
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
        <!-- declare a td to be sortable -->
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

### Add pagination

```html
  <!-- reference the pager defined below -->
  <table at-table class="table" list="list" pager="pager">
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
  <!-- define the name of this pagers instance in the scope.
       the pager must have a reference to the rendered list in order to render the pagination. -->
  <at-pager items-per-page="5" instance="pager" list="list" />

```
