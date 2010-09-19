package main.helpers
{
    public class PersonVo
    {
        public var name:String;
        public var surname:String;
        public var age:int;
        public var country:String;
        
        public function PersonVo(name:String, surname:String, age:int, country:String)
        {
            this.name = name;
            this.surname = surname;
            this.age = age;
            this.country = country;
        }
    }
}