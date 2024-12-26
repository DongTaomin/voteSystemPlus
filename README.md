# voteSystemPlus
利用 JSP + JavaBean + Servlet 技术来实现一个“喜欢的大学投票系统”，添加后台管理,包括用户注册、登录、投票和查看投票结果的功能。通过将三者结合，充分展示 Java Web 应用中前后端的交互，以及通过数据库实现持久化数据存储。



项目结构:

voteSystemPlus/
│
├── src/                          # Java 源码目录
│   ├── model/                    # 数据库模型类
│   │   ├── User.java             # 用户模型类
│   │   ├── University.java       # 大学模型类
│   │   ├── Issue.java            # 问题模型类                  
│   │   ├── UserDAO.java          # 用户数据访问对象
│   │   ├── UniversityDAO.java    # 大学数据访问对象
│   │   ├── IssueDAO.java         # 问题数据访问对象

│   │   ├── Vote.java    				# 投票类
│   │   ├── VoyeDAO.java         # 投票数据访问对象

│   ├── servlet/                  # Servlet 层
│    |    ├── LoginServlet.java    	   # 登录功能 Servlet
│    |    ├── RegisterServlet.java  	 # 注册功能 Servlet
│    |    ├── VoteServlet.java 			 # 用户投票 Servlet
|     |--── util/                     # 工具目录
│    |    |── DBHelper              # 数据库连接类
│ 
├── .gitignore                    # Git 忽略文件
├── README.md                     # 项目说明文件
