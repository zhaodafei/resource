<?php
abstract class User{
    function __construct($name)
    {
        $this->name = $name;  //exit($this->name);
    }

    function getName()
    {
        return $this->name; //exit($this->name."eeeeee");
    }

    //权限方法
    function hasReadPermission()
    {
        return true;
    }

    function hasModifyPermission()
    {
        return false;
    }

    function hasDeletePermission()
    {
        return false;
    }
    //订制的方法
    function wantsFlashInterface()
    {
        return true;
    }
    protected $name = null;
}

class GuestUser extends User{
}

class CustomerUser extends User{
    function hasModifyPermission()
    {
        return true;
    }
}

class AdminUser extends User{
    function hasModifyPermission()
    {
        return true;
    }

    function hasDeletePermission()
    {
        return true;
    }

    function wantsFlashInterface()
    {
        return false;
    }
}

class UserFactory
{
    private static $user = array('Andi' => 'admin', 'Stig' => 'guest', 'Derick' => 'customer');

    static function Create($name)
    {
        if (!isset(self::$user[$name])) {
            //报错因为用户不存在
        }//exit(self::$user[$name]);
        switch (self::$user[$name]) {
            case 'guest'://exit('1');
                return new GuestUser($name);
                break;
            case 'customer'://exit('2');
                return new CustomerUser($name);
                break;
            case 'admin'://exit('3');
                return new AdminUser($name);
                break;
            default://exit('4');
                exit('报出错误,因为用户类型不存在');
        }
    }
}


function boolToStr($b)
{
    if ($b == true) {
        return "Yes\n";
    }else{
        return "No\n";
    }
}

function displayPermissions(User $obj)
{
    print  $obj->getName() . "`s permissions:\n";
    print 'Read: ' . boolToStr($obj->hasReadPermission());
    print 'Modify: ' . boolToStr($obj->hasModifyPermission());
    print 'Delete: ' . boolToStr($obj->hasDeletePermission());
}

function displayRequirements(User $obj)
{
    if ($obj->wantsFlashInterface()) {
        print $obj->getName() . "requires Flash\n";
    }
}

$logins = array('Andi', 'Stig', 'Derick');
foreach ($logins as $loging) {
    displayPermissions(UserFactory::Create($loging));
    displayRequirements(UserFactory::Create($loging));
}


