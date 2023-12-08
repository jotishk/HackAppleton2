<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<html>
  <!-- Add image and about panels on side-->
  <head>
    <link rel = "stylesheet" href = "HACreatePage.css">
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
      <a class = "create-button" href = ""><span class = "side-bar-text">Create</span></a>
      <a class = "discussion-button" href = ""><span class = "side-bar-text">Discussion</span></a>
    </div>
    <div class = "addpost-box">
      <p class = "title-text">Add New Discussion</p>
      <form enctype="multipart/form-data" action = "HACreatePage.jsp" method = "post">
        <!-- <input class = "set-anonymous"> -->
        <input class = "title-input" type = "text" name = "title-input" placeholder="Enter title here">
        <textarea class = "text-box" name = "content-input" placeholder="Content goes here..." ></textarea>
        <div class = "submit-box">
          <div class = "publish-text-box">
            <p class = "publish-text">Publish</p>
          </div>
          <button class = "save-button">Save Draft</button>
          <input class = "publish-button" type = "submit" value = "Publish">
        </div>
        <div class = "submit-box">
          <div class = "publish-text-box">
            <p class = "publish-text">Publish</p>
          </div>
          <button class = "save-button">Save Draft</button>
          <input class = "publish-button" type = "submit" value = "Publish">
        </div>
      </form>
      
    </div>
  </body>
  <%
    String DiscussionOwner = "TestAccount1";
    String DiscussionTitle = request.getParameter("title-input");
    String DiscussionContent = request.getParameter("content-input");
    int DiscussionID = (int)(Math.random() *1000);
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");      
    PreparedStatement pstmt = c.prepareStatement("insert into HADiscussions(DiscussionOwner, DiscussionTitle, DiscussionContent, DiscussionID) values (?,?,?,?)");
    pstmt.setString(1, DiscussionOwner);
    pstmt.setString(2,DiscussionTitle);
    pstmt.setString(3, DiscussionContent);
    pstmt.setDiscussionID(4,DiscussionID)
  %>
  <script>
    let isSignedIn = true;
    const usernameElement = document.querySelector(".username");
    let username = "TestAccount1"
    
    if (isSignedIn) {
      usernameElement.innerText = username;
    }
  </script>
</hmtl>
