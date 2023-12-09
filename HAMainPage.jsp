<!DOCTYPE html>
<%
  try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "orcl");
    
  } catch (Exception e) {

  }
%>
<html>
  <head>
    <link rel = "stylesheet" href = "HAMainPage.css">
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
    <div class = "dashboard-box">
      <p class = "tp-text">Top Posts This Week</p>
      <div class = "tp-box">
        <div class = "tp-card">
          <div class = "tp-image-box">
            
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username">Example Username</p>
          </div>
          <div class = "tp-title">Title</div>
          <div class = "tp-description">Example Description Example Description Example Description Example Description Example Descri...</div>
          <div class = "learn-more-box">
            <a>
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"># Comments</div>
        </div>
        <div class = "tp-card">
          <div class = "tp-image-box">
            
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username">Example Username</p>
          </div>
          <div class = "tp-title">Title</div>
          <div class = "tp-description">Example Description Example Description Example Description Example Description Example Descri...</div>
          <div class = "learn-more-box">
            <a>
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"># Comments</div>
        </div>
        <div class = "tp-card">
          <div class = "tp-image-box">
            
          </div>
          <div class = "author-box">
            <img class = "author-image" src = "EmptyAvatar.jpg">
            <p class = "author-username">Example Username</p>
          </div>
          <div class = "tp-title">Title</div>
          <div class = "tp-description">Example Description Example Description Example Description Example Description Example Descri...</div>
          <div class = "learn-more-box">
            <a>
              <button class = "learn-more-button">Learn More</button>
            </a>
          </div>
          <div class = "tp-comment"># Comments</div>
        </div>
      </div>
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
