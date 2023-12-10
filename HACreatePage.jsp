<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<html>
  <!-- Add image and about panels on side-->
  <head>
    <link rel = "stylesheet" href = "HACreatePage.css">
  </head>
  <body>
    <div class = "header">
      <p class = "logo-name">Website Name</p>
      <form enctype="multipart/form-data" action = "HASearchPage.jsp" method = "post">
        <button type = "submit" class="search-button">
        <img class = "search-image" src = "595474_search_512x512.png">
        </button>
        <input list = "categories" name = "search-input" class = "search-bar" placeholder="Search"> 
        <datalist id="categories">
          <option value="Mental Health Awareness">
          <option value="Bullying and Cyberbullying">
          <option value="Environment">
          <option value="Social Media Impact">
          <option value="Academic Pressure">
        </datalist> 
      </form>
      <input class = "search-bar" placeholder="Search">  
      <div class = "profile">
        <img class = "profile-image" src = "EmptyAvatar.jpg">
        <p class = "username"></p>
      </div>
    </div> 
    <div class = "side-bar">
      <a class = "dashboard-button" href = "HAMainPage.jsp"><span class = "side-bar-text">Dashboard</span></a>
      <a class = "create-button" href = "HACreatePage.jsp"><span class = "side-bar-text">Create</span></a>
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
        <div class = "add-image-box">
          <div class = "publish-text-box">
            <p class = "publish-text">Add a thumbnail</p>
          </div>
          <input class = "image-input" type ="file" value = "Upload" name = "discussionimage" >
          <button type = "button" onclick = "uploadFile();" class = "image-input-button">Upload Image</button>
        </div>
        <div class = "select-category-box">
          <div class = "publish-text-box">
            <p class = "publish-text">Select Category</p>
          </div>
          <input list="categories" class="category-input" name="category" >
          <datalist id="categories">
            <option value="Mental Health Awareness">
            <option value="Bullying and Cyberbullying">
            <option value="Environment">
            <option value="Social Media Impact">
            <option value="Academic Pressure">
          </datalist>
        </div>
      </form>
      
    </div>
  </body>
  <%
    if (request.getMethod().equalsIgnoreCase("POST")) {
      try { 
        String DiscussionOwner = "TestAccount1";
        Part discussionImage = request.getPart("discussionimage");
        InputStream fin = discussionImage.getInputStream();
        String DiscussionTitle = request.getParameter("title-input");
        String DiscussionContent = request.getParameter("content-input");
        String DiscussionCategory = request.getParameter("category");
        int DiscussionID = (int)(Math.random() *100000);
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");      
        PreparedStatement pstmt = c.prepareStatement("insert into HADiscussions(DiscussionOwner, DiscussionTitle, DiscussionImage, DiscussionContent, DiscussionID, DiscussionCategory) values (?,?,?,?,?,?)");
        pstmt.setString(1, DiscussionOwner);
        pstmt.setString(2,DiscussionTitle);
        pstmt.setBlob(3,fin);
        pstmt.setString(4, DiscussionContent);
        pstmt.setInt(5,DiscussionID);
        pstmt.setString(6,DiscussionCategory);
        pstmt.executeUpdate();
        c.commit();
        
        c.close();
      } catch(Exception e) {
        System.out.println(e);
      }
    }
  %>
  <script>
    let isSignedIn = true;
    const usernameElement = document.querySelector(".username");
    let username = "TestAccount1"
    
    if (isSignedIn) {
      usernameElement.innerText = username;
    }

    const imageInput = document.querySelector(".image-input");
    function uploadFile() {
      imageInput.click();
    }
  </script>
</hmtl>
