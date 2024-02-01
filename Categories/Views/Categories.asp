<title>Categories List</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<script src="categories.js" defer type="module"></script>
<!-- end of links -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
RedirectIfNotLoggedIn
%>

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <div class="spinner">
        <div class="spinner__overlay"></div>
      </div>
    </section>
  </main>
</div>

<style>
.section--main {
  display: flex;
  flex-flow: row nowrap;
  justify-content: center;
}

.spinner {
  width: 32px;
  height: 32px;

  border-radius: 50%;
  border: 4px #057299 solid;
  border-bottom-color: transparent;
  border-right-color: transparent;
  
  animation-name: rotate;
  animation-duration: 0.7s;
  animation-iteration-count: infinite;

  display: flex;
  position: relative;
}

.spinner__overlay {
  width: 50%;
  height: 100%;
  background-color: white;

  height: calc(40px + 8px);
  width: calc(20px + 4px);

  position: absolute;
  top: -8px;
  left: -8px;

  transform-origin: 100% 50%;

  animation-name: rotate2;
  animation-duration: 2s;
  animation-fill-mode: both;
  animation-iteration-count: infinite;
}

@keyframes rotate {
  from {
      transform: rotate(0deg);
  }
  to {
      transform: rotate(360deg);;
  }
}

@keyframes rotate2 {
  from {
      transform: rotate(-45deg);

  }

  50%, 75% {
    transform: rotate(180deg);
  }

  to {
      transform: rotate(315deg);
  }
}
</style>