class JobRuleNumber
  @queue = :webo_jobs
  def self.perform
    database = YAML.load_file(File.join(Rails.root.to_s, 'config', 'database.yml'))[Rails.env || "development"]
    dbh = Mysql2::Client.new(:host => database["host"],:username => database["username"],:password => database["password"])
    dbh.query("USE `#{database['database']}`;")
    dbh.query('set names utf8;');
    sql = "delete from rulenumbers where created_at >= '#{Time.new.strftime("%Y-%m-%d")}'"
    dbh.query(sql)
    sql = "insert into rulenumbers(RuleID, RuleNum, created_at) 
    select RuleID,count(*), now() from weibo_rules group by RuleID"
    dbh.query(sql)
    dbh.close
    
    treeall = RuleDef.find(:all, :conditions => ["RuleType = 1"])
    treeall.each do |t|
      if RuleDef.count(:conditions => ["ParentID = ?", t.id]) == 0 then
        AddParent.new.addparent(t.id)
      end
    end
    rnall = Rulenumber.find(:all, :conditions => ["created_at >= ?", Time.new.strftime("%Y-%m-%d")])
    rnall.each do |r|
      if RuleDef.count(:conditions => ["id = ?", r.RuleID]) > 0  then
        RuleDef.update(r.RuleID,{:MonitCnt => r.RuleNum})
      end
    end
  end
end
class AddParent
  def addparent(ruleid)
    @parentid = RuleDef.find(ruleid).ParentID ? RuleDef.find(ruleid).ParentID : -1
    if @parentid != -1 then
      @parent = Rulenumber.find(:all,:conditions => ["RuleID = ?",@parentid])
      @sun = Rulenumber.find(:all,:conditions => ["RuleID = ?",ruleid])
      @count = @sun[0].RuleNum.to_i + @parent[0].RuleNum.to_i
      Rulenumber.update(@parent[0].id,{:RuleNum => @count})
      addparent(@parentid)
    end
  end
end