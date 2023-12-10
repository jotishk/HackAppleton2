<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
  ArrayList<Integer> discussions = new ArrayList<>();
  ArrayList<String[]> discussionAndComments = new ArrayList<>();
  ArrayList<String[]> topDiscussions = new ArrayList<>();

  ArrayList topDiscussion1 = new ArrayList();
  ArrayList topDiscussion2 = new ArrayList();
  ArrayList topDiscussion3 = new ArrayList();

  String selectedCategory = request.getParameter("search-input");


  try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");

    Statement stmt = c.createStatement();
    Statement stmt2 = c.createStatement();
    ResultSet DBDiscussionIDs = stmt.executeQuery("select * from HADiscussions");
    ResultSet discussionDetails = stmt2.executeQuery("select * from HADiscussions");
    
    while (DBDiscussionIDs.next()) {
      if (DBDiscussionIDs.getString("DiscussionCategory").toLowerCase().equals(selectedCategory.toLowerCase())) {
        discussions.add(DBDiscussionIDs.getInt("DiscussionID"));
      }
      
    }
    
    DBDiscussionIDs.close();
    
     for (int i: discussions) {
      PreparedStatement pstmt = c.prepareStatement("select Count(*) as commentCount from HAComments where DiscussionID = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
      pstmt.setInt(1,i);
      ResultSet amountOfComments = pstmt.executeQuery();
      if (amountOfComments.next()) {
        discussionAndComments.add(new String[]{String.valueOf(i), String.valueOf(amountOfComments.getInt("commentCount"))});
      }
      amountOfComments.first();
       
    }
    
    

    for (String[] s: discussionAndComments) {
      if (topDiscussions.size() <3) {
        topDiscussions.add(new String[]{s[0],s[1]});
      } else {
        for (String[] w : topDiscussions) {
          if (Integer.parseInt(s[1]) < Integer.parseInt(w[1])) {
            continue;
          } else {
            for (int i=0; i<topDiscussions.size();i++) {
              if (Arrays.equals(new String[]{w[0],w[1]}, topDiscussions.get(i))) {
                topDiscussions.remove(i);
              }
            }
            topDiscussions.add(new String[]{s[0],s[1]});
            break;
          }
        }
      }
    }
    
    while (discussionDetails.next()) {
      
      if (discussionDetails.getInt("DiscussionID") == Integer.parseInt(topDiscussions.get(0)[0])) {
        
          topDiscussion1.add(discussionDetails.getInt("DiscussionID"));
          
          topDiscussion1.add(topDiscussions.get(0)[1]);
          
          topDiscussion1.add(discussionDetails.getString("DiscussionOwner"));
          topDiscussion1.add(discussionDetails.getString("DiscussionTitle"));
          String descriptionWhole = discussionDetails.getString("DiscussionContent");
          String description;
          if (descriptionWhole.length() >100) {
            description = descriptionWhole.substring(0,100)+ "...";
          } else {
            description = descriptionWhole;
          }
          topDiscussion1.add(description);
          topDiscussion1.add(discussionDetails.getString("DiscussionTitle"));
          topDiscussion1.add(discussionDetails.getBytes("DiscussionImage"));
        
        
        
      } else if (topDiscussions.size() > 1 && discussionDetails.getInt("DiscussionID") == Integer.parseInt(topDiscussions.get(1)[0])) {
       
          topDiscussion2.add(discussionDetails.getInt("DiscussionID"));
          topDiscussion2.add(topDiscussions.get(1)[1]);
          topDiscussion2.add(discussionDetails.getString("DiscussionOwner"));
          topDiscussion2.add(discussionDetails.getString("DiscussionTitle"));
          String descriptionWhole = discussionDetails.getString("DiscussionContent");
          String description;
          if (descriptionWhole.length() >100) {
            description = descriptionWhole.substring(0,100)+ "...";
          } else {
            description = descriptionWhole;
          }
          topDiscussion2.add(description);
          topDiscussion2.add(discussionDetails.getString("DiscussionTitle"));
          topDiscussion2.add(discussionDetails.getBytes("DiscussionImage"));
        
      } else if (topDiscussions.size() > 2 &&  discussionDetails.getInt("DiscussionID") == Integer.parseInt(topDiscussions.get(2)[0])) {
       
          topDiscussion3.add(discussionDetails.getInt("DiscussionID"));
          topDiscussion3.add(topDiscussions.get(2)[1]);
          topDiscussion3.add(discussionDetails.getString("DiscussionOwner"));
          topDiscussion3.add(discussionDetails.getString("DiscussionTitle"));
          String descriptionWhole = discussionDetails.getString("DiscussionContent");
          String description;
          if (descriptionWhole.length() >100) {
            description = descriptionWhole.substring(0,100)+ "...";
          } else {
            description = descriptionWhole;
          }
          topDiscussion3.add(description);
          topDiscussion3.add(discussionDetails.getString("DiscussionTitle"));
          topDiscussion3.add(discussionDetails.getBytes("DiscussionImage"));
        
      }
    }
  
    discussionDetails.close(); 
    
    
    
  } catch (Exception e) {
    e.printStackTrace();
  }
%>
<html>
  <head>
    <link rel = "stylesheet" href = "HAMainPage.css">
  </head>
  <body>
    <div class = "header">
      <img class = "logo-image" src = "Logo.png">
      <p class = "logo-name">Student Buzz</p>
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
          <option value="Technology">
        </datalist> 
      </form>
      
      <div class = "profile">
        <img class = "profile-image" src = "EmptyAvatar.jpg">
        <p class = "username"></p>
      </div>
    </div> 
    <div class = "side-bar">
      <a class = "dashboard-button" href = "HAMainPage.jsp"><span class = "side-bar-text">Dashboard</span></a>
      <a class = "create-button" href = "HACreatePage.jsp"><span class = "side-bar-text">Create</span></a>
      <a class = "discussion-button" href = ""><span class = "side-bar-text">Discussion</span></a>
      <a class = "search-sidebar-button" href = ""><span class = "side-bar-text">Search</span></a>

    </div>
    <div class = "dashboard-box">
      <p class = "tp-text">Results</p>
      <div class = "tp-box">
        <% if (topDiscussion1.size() > 0) { %>
        <div class = "tp-card">
          <div class = "tp-image-box">
            <img src = "data:image/png;base64,<%=new String(java.util.Base64.getEncoder().encode((byte[])topDiscussion1.get(6))) %>" class = "tp-image">
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username"><%=topDiscussion1.get(2)%></p>
          </div>
          <div class = "tp-title"><%=topDiscussion1.get(3)%></div>
          <div class = "tp-description"><%=topDiscussion1.get(4)%></div>
          <div class = "learn-more-box">
            <a href = "HADiscussionPage.jsp?value=<%=topDiscussion1.get(0)%>">
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"><%= topDiscussion1.get(1)%> Comments</div>
        </div>
        <% } %>
        <%  if (topDiscussion2.size() > 0) { %>
        <div style = "margin-left: 100px;"class = "tp-card">
          <div class = "tp-image-box">
            <img src = "data:image/png;base64,<%=new String(java.util.Base64.getEncoder().encode((byte[])topDiscussion2.get(6))) %>" class = "tp-image">
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username"><%=topDiscussion2.get(2)%></p>
          </div>
          <div class = "tp-title"><%=topDiscussion2.get(3)%></div>
          <div class = "tp-description"><%=topDiscussion2.get(4)%></div>
          <div class = "learn-more-box">
            <a href = "HADiscussionPage.jsp?value=<%=topDiscussion2.get(0)%>">
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"><%=topDiscussion2.get(1)%> Comments</div>
        </div>
        <% } %>
        <% if (topDiscussion3.size() > 0) { %>
        <div style = "margin-left: 100px;" class = "tp-card">
          <div class = "tp-image-box">
            <img src = "data:image/png;base64,<%=new String(java.util.Base64.getEncoder().encode((byte[])topDiscussion3.get(6))) %>" class = "tp-image">
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username"><%=topDiscussion3.get(2)%></p>
          </div>
          <div class = "tp-title"><%=topDiscussion3.get(3)%></div>
          <div class = "tp-description"><%=topDiscussion3.get(4)%></div>
          <div class = "learn-more-box">
            <a href = "HADiscussionPage.jsp?value=<%=topDiscussion3.get(0)%>">
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"><%=topDiscussion3.get(1)%> Comments</div>
        </div>
        <% } %>
      </div>
    </div>
  </body>
  <script>
    let isSignedIn = true;
    const usernameElement = document.querySelector(".username");
    let username = "TestAccount"
    
    if (isSignedIn) {
      usernameElement.innerText = username;
    }
  </script>
</hmtl>