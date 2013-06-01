# angular-table

A directive for creating sortable tables with pagination.

# Examples

## No sorting, no pagination

```html
  <table at-table class="table" list="filteredList">
    <thead></thead>
    <tbody>
      <tr>
        <td at-implicit attribute="id"></td>
        <td at-implicit attribute="description" title="the description"></td>
        <td title="name">
          {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>
```

## Enable sorting for any column

```html
  <table at-table class="table" list="filteredList">
    <thead></thead>
    <tbody>
      <tr>
        <td sortable at-implicit attribute="id"></td>
        <td sortable at-implicit attribute="description" title="the description"></td>
        <td title="name">
          {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>
```

## Add pagination

```html
  <table at-table class="table" list="filteredList" pager="pager">
    <thead></thead>
    <tbody>
      <tr>
        <td sortable at-implicit attribute="id"></td>
        <td sortable at-implicit attribute="description" title="the description"></td>
        <td title="name">
          {{item.name}}
        </td>
      </tr>
    </tbody>
  </table>

  <at-pager items-per-page="5" instance="pager" list="filteredList" />

```
