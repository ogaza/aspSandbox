<title>Categories List</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<script src="categories.js" defer></script>
<script src="categoriesSearch.js" defer></script>
<!-- <script src="categories.js" defer type="module"></script> -->
<link rel="stylesheet" href="spinner.css" />
<link rel="stylesheet" href="search.css" />
<!-- end of links -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
RedirectIfNotLoggedIn
%>

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<div class="wrapper">
  <main class="main">

    <div>
      <button class="search__button" onClick="javascript:showSearch()"> 
        Search
      </button>
    </div>

    <div class="search">
    </div>

    <section class="section--main">
      <!-- main page content -->

      <div class="table">
        <div class="spinner">
          <div class="spinner__overlay"></div>
        </div>
      </div>

    </section>
  </main>
</div>

<template>
  <div class="search__popup">
    <div class="search__header">
      <div class="search__title">
        Search
      </div>
      <button class="search__close" onClick="javascript:hideSearch()">
        x
      </button>
    </div>
    <div class="search__content">
      <div class="search__fields">
        <div class="search__field">
          CategoryID:
        </div>
        <div class="search__value">
          <input type="text" value=""/>
        </div>
      </div>
    </div> 

  </div>
</template>