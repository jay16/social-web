class K
  class_methods = %w(he llo wor ld)
  class_methods.each do |c_m|
    name = "self." + c_m
    self.class_eval( "def #{name}; @@#{c_m};end" ) 
    self.class_eval( "def #{name}=(val); @@#{c_m}=val;end" ) 
  end   
  
  define_method "jay" do
    puts "jay"
  end
end
K.he = "hi"
puts K.he
K.new.jay
