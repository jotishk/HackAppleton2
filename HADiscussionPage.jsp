<!DOCTYPE html>
<%String articleID = request.getParameter("value");%>
<%
  
  String articleTitle = "";
  String author = "";
  String article = "";
  String category = "";
  byte[] imageBytes = new byte[0];
  ArrayList<String[]> commentsList = new ArrayList<>();
  int numberOfComments = 0;
  try {
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");

    Statement stmt = c.createStatement();
    Statement stmt2 = c.createStatement();

    ResultSet discussions = stmt.executeQuery("select * from HADiscussions");
    ResultSet DBcomments = stmt2.executeQuery("select * from HAComments");
    while (discussions.next()) {
      if (Integer.parseInt(articleID) == discussions.getInt("DiscussionID")) {
        articleTitle = discussions.getString("DiscussionTitle");
        author = discussions.getString("DiscussionOwner");
        article = discussions.getString("DiscussionContent");
        imageBytes = discussions.getBytes("DiscussionImage");
        category = discussions.getString("DiscussionCategory");
      }
    }

    category = category.toLowerCase().replace(" ","-");
    while (DBcomments.next()) {
      if (Integer.parseInt(articleID) == DBcomments.getInt("DiscussionID")) {
        commentsList.add(new String[]{DBcomments.getString("CommenterName"), DBcomments.getString("CommentText")});
        numberOfComments++;
      }
    }
    
  } catch (Exception e) {
    System.out.println(e);
  }
  
%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.collection.*" %>


<html>
  <head>
    <link rel = "stylesheet" href = "HADiscussionPage.css">
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
    <div class = "discussion-box">
      <div class = "category-box"># <%=category%></div>
      <img src = "data:image/png;base64,<%=new String(java.util.Base64.getEncoder().encode(imageBytes)) %>" class = "article-image">
      <div class = "article-details">
        <p class = "article-title"><%=articleTitle%></p>
        <div class = "author-details">
          <img class = "profilepic-image" src = "EmptyAvatar.jpg">
          <p class = "owner-username"><%=author%></p>
        </div>
        
      </div>
      <p class = "body-text"><%=article%></p>
      <div class = "comment-box">
        <p class = "comment-title"><%=numberOfComments%> Comments</p>
        <div class = "create-comment-box">
          <img class = "your-comment-profile-image" src = "EmptyAvatar.jpg">
          <form  class = "create-comment-form" style = "display: inline;" enctype="multipart/form-data" action = "HADiscussionPage.jsp?value=<%=articleID%>" method = "post">
            <input class = "create-comment-input" type = "text" name = "comment-input">
          </form>
          
        </div>
          <% for (String[] s: commentsList) { %>
            <div class = "article-comment">
              <img class = "comment-profile-image" src = "EmptyAvatar.jpg">
              <div class = "comment-content">
                <p style = "margin: 5px; font-weight: 600; font-family:'Roboto', sans-serif;"><%=s[0]%></p>
                <p style = "margin: 5px; font-family:'Roboto', sans-serif;"   class = "comment-text"><%=s[1]%></p>
              </div>
            </div>
          <% } %>
      </div>
      
    </div>
  </body>
  <%
    if (request.getMethod().equalsIgnoreCase("POST")) {
      try { 
        
        String CommentContent = request.getParameter("comment-input");
        String CommenterName = "TestAccount1";
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");      
        PreparedStatement pstmt = c.prepareStatement("insert into HAComments(DiscussionID,CommenterName,CommentText) values (?,?,?)");
        pstmt.setInt(1,Integer.parseInt(articleID));
        pstmt.setString(2, CommenterName);
        pstmt.setString(3,CommentContent);
        
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
    const commentInput = document.querySelector(".create-comment-input");
    let postButton = document.createElement("input");
    postButton.className = "post-button";
    postButton.type = "submit";
    postButton.value = "Comment"
    commentInput.addEventListener("focus", function() {
      document.querySelector(".create-comment-form").appendChild(postButton);
    });
    commentInput.addEventListener("blur", function() {
      setTimeout(function() {
        document.querySelector(".create-comment-form").removeChild(postButton);
      },200);
      
    });
    if (isSignedIn) {
      usernameElement.innerText = username;
    }
  </script>
</html>