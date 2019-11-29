# Auth_Ldap [![Build Status](https://travis-ci.org/gwojtak/Auth_Ldap.svg?branch=master)](https://travis-ci.org/gwojtak/Auth_Ldap)
A library to provide LDAP authentication in your CodeIgniter application

## Installation Instructions
1. Download this zip archive
2. Unzip to a temporary location
3. Change into the Auth_Ldap directory
4. Recursively copy the library into your application/ directory
5. Configure the library

A typical example of this process would be:

```
$ git clone https://github.com/gwojtak/Auth_Ldap
$ cd Auth_Ldap
$ cp -r config libraries /path/to/codeigniter/install/application/
```
If you'd like the example views and controllers, also run
```
$ cp -r controllers views /path/to/codeigniter/install/application
```

## Usage Instructions
The best way to get an idea of how to use this library is to view the sample
controllers and views that are included in the distribution package.  To get 
started, include the line 

```php
$this->load->library('Auth_Ldap');
```

somewhere in your controller.  A typical example would be something like:

```php
class Some_controller extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        
        $this->load->library('Auth_Ldap');
        /*  Load other libraries and helpers... */
    }

    function login() {
        /* Logic to display form and retrieve username and password values */
        $this->auth_ldap->login($username, $password);
     
        $this->load->next_step_in_app();
    }
}
```

## Roles
The Auth_Ldap library supports the concept of roles, wherein you can separate 
users into different groups to perform different functions.  One of the most
common uses of this is to divvy users up as, say, Guests, Users, and Admins.
That being the case, the your `config/auth_ldap.php` would be modified to contain
the following line:

```php
$config['roles'] = array( 1 => 'Guest', 3 => 'User', 5 => 'Admin');
```

In your controller, you'd call your view with:
```php
$this->load->view('my_view', array('role' => $this->session->userdata('role'));
```

In your view then, you could do something like:

```php
if( $role > 3 ) {
    /* Display stuff a User (from above) isn't supposed to see.
       That is, only an Admin should see this */
}

if ( $role > 1 ) {
   /* Display stuff that an Admin or a User can see. */
}

/* Display other items that anyone (Guest) can see */
```

The trick to using roles in this fashion is to create an LDAP group with the 
name of the role you are using.  So in this example, we'd have:

```
cn=Admin,ou=Roles,dc=mydomain,dc=com
cn=User,ou=Roles,dc=mydomain,dc=com
cn=Guest,ou=Roles,dc=mydomain,dc=com
```

The Admin object could have the attributes:

```
memberUid: gwojtak
memberUid: root
```
meaning that signing in as gwojtak or root would give you an admin role.

Note that these role names and id's are completely arbitrary.  You can choose
not to use them at all if you wish.
 
Enjoy!

## Configuration
In `application/config/auth_ldap.php`

```php
$config['ldap_uris'] = array('ldap://ldap.mycompany.com:389');
$config['basedn'] = 'dc=mycompany,dc=com';
$config['login_attribute'] = 'uid';
$config['proxy_user'] = '';
$config['proxy_pass'] = '';
$config['roles'] = array(1 => 'User', 
    3 => 'Power User',
    5 => 'Administrator');
$config['member_attribute'] = 'memberUid';
$config['auditlog'] = 'application/logs/audit.log';  // Some place to log attempted logins (separate from message log)
```
| Key              | Type   | Description                                                                             |
|------------------|--------|-----------------------------------------------------------------------------------------|
| hosts            | array  | a list of LDAP servers                                                                  |
| ports            | array  | array of ports to associate with servers in `hosts`                                     |
| basedn           | string | Base DN to search through in LDAP                                                       |
| login_attribute  | string | the LDAP attribute to query (usually uid or sAMAccountName)                             |
| proxy_user       | string | distinguished name of a proxy user                                                      |
| proxy_pass       | string | password of the above                                                                   |
| roles            | array  | array of role names                                                                     |
| member_attribute | string | the attribute in LDAP that identifies a member of a group (member for AD or rfc2307bis) |
| auditlog         | string | path to an audit log for LDAP authentication attempts                                   |

## Donations
If you get use out of Auth_Ldap for you CodeIgniter app, please consider a donation.

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick" />
<input type="hidden" name="hosted_button_id" value="6FJA9FKMA7CTA" />
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
</form>

| Crypto        |                                            |
|---------------|--------------------------------------------|
| Bitcoin:      | 3Qvu1C8gFjdJa85mFf1de5EteWt46CkY81         |
| Bitcoin Cash: | qpk0k0lv5elly2h9e7k7d92nwjhsafngrym2ezr4xa |
| Litecoin:     | M96796s5j5YFdfWtp43yDFxVosSn4jGLW3         |
| Ethereum:     | 0xa94671089a1f44774edc8Ae656EB737C6024f8e2 |
| Dai:          | 0x5F1EE697372292eb9018D5BD1ED06eeDDD8E2459 |
