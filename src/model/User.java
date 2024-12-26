package model;

public class User {
    private int id;
    private String name;
    private String password;
    private String sex;
    private boolean hasVoted;  // 标记是否已投票
    private String role;  // 添加角色字段

    // 其他字段和构造方法省略

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getSex() { return sex; }
    public void setSex(String sex) { this.sex = sex; }

    public boolean hasVoted() {
        return hasVoted;
    }

    public void setHasVoted(boolean hasVoted) {
        this.hasVoted = hasVoted;
    }
}
