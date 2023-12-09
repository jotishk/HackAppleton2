<!DOCTYPE html>
<%String articleID = request.getParameter("value");%>
<html>
  <head>
    <link rel = "stylesheet" href = "HADiscussionPage.css">
  </head>
  <body>
    <div class = "header">
      <p class = "logo-name">Website Name</p>
      <button class="search-button">
      <img class = "search-image" src = "595474_search_512x512.png">
      </button>
      <input class = "search-bar" placeholder="Search">  
      <div class = "profile">
        <img class = "profile-image" src = "EmptyAvatar.jpg">
        <p class = "username"></p>
      </div>
    </div> 
    <div class = "side-bar">
      <a class = "dashboard-button" href = "HAMainPage.html"><span class = "side-bar-text">Dashboard</span></a>
      <a class = "create-button" href = "HACreatePage.html"><span class = "side-bar-text">Create</span></a>
      <a class = "discussion-button" href = ""><span class = "side-bar-text">Discussion</span></a>
    </div>
    <div class = "discussion-box">
      <img class = "article-image">
      <div class = "article-details">
        <p class = "article-title">Example Title</p>
        <img class = "profilepic-image" src = "EmptyAvatar.jpg">
        <p class = "owner-username">Example Username</p>
      </div>
      <p class = "body-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
      </div>
  </body>
  <script>
    let isSignedIn = true;
    const usernameElement = document.querySelector(".username");
    let username = "TestAccount1"
    
    if (isSignedIn) {
      usernameElement.innerText = username;
    }
  </script>
</hmtl>