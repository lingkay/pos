<?php

namespace Gist\UserBundle\Entity;

use FOS\UserBundle\Model\User as BaseUser;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use FOS\UserBundle\Model\GroupInterface;
use Gist\MediaBundle\Entity\Upload;
use stdClass;
use DateTime;

/**
 * @ORM\Entity
 * @ORM\Table(name="user_user")
 * @ORM\AttributeOverrides({
 *      @ORM\AttributeOverride(name="email", column=@ORM\Column(type="string", name="email", length=255, unique=false, nullable=true)),
 *      @ORM\AttributeOverride(name="emailCanonical", column=@ORM\Column(type="string", name="email_canonical", length=255, unique=false, nullable=true))
 * })
 */
class User extends BaseUser
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /** @ORM\Column(type="string", length=50, nullable=true) */
    protected $erp_id;

    /** @ORM\Column(type="string", length=50, nullable=true) */
    protected $name;

    protected $acl_cache;

    /**
    *
    * @ORM\Column(type="boolean") 
    */
    protected $flag_emailnotify;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $first_name;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $middle_name;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $last_name;

    /** @ORM\Column(type="string", length=250, nullable=true) */
    protected $agency;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $approver;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $approver_code;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $area;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $brand;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $department;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $position;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $commission_type;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $contact_number;

    public function __construct()
    {
        parent::__construct();
        $this->roles = array();
        // $this->groups = new ArrayCollection();
        $this->acl_cache = array();
        $this->flag_emailnotify = true;
    }

    public function setDepartment($department)
    {
        $this->department = $department;
        return $this;
    }

    public function getDepartment()
    {
        return $this->department;
    }

    public function setPosition($position)
    {
        $this->position = $position;
        return $this;
    }

    public function getPosition()
    {
        return $this->position;
    }

    public function setFirstName($first_name)
    {
        $this->first_name = $first_name;
        return $this;
    }

    public function getFirstName()
    {
        return $this->first_name;
    }

    public function setMiddleName($middle_name)
    {
        $this->middle_name = $middle_name;
        return $this;
    }

    public function getMiddleName()
    {
        return $this->middle_name;
    }

    public function setLastName($last_name)
    {
        $this->last_name = $last_name;
        return $this;
    }

    public function getLastName()
    {
        return $this->last_name;
    }

    public function getDisplayName()
    {
        if ($this->last_name == '' && $this->first_name == '') {
            return 'N/A';
        }
        return $this->last_name.', '.$this->first_name;
    }

    public function setAgencyName($agency)
    {
        $this->agency = $agency;
        return $this;
    }

    public function getAgencyName()
    {
        return $this->agency;
    }

    public function setApprover($approver)
    {
        $this->approver = $approver;
        return $this;
    }

    public function getApprover()
    {
        return $this->approver;
    }

    public function setERPID($erp_id)
    {
        $this->erp_id = $erp_id;
        return $this;
    }

    public function getERPID()
    {
        return $this->erp_id;
    }

    public function setApproverCode($approver_code)
    {
        $this->approver_code = $approver_code;
        return $this;
    }

    public function getApproverCode()
    {
        return $this->approver_code;
    }

    public function setArea($area)
    {
        $this->area = $area;
        return $this;
    }

    public function getArea()
    {
        return $this->area;
    }

    public function setBrand($brand)
    {
        $this->brand = $brand;
        return $this;
    }

    public function getBrand()
    {
        return $this->brand;
    }

    public function setCommissionType($commission_type)
    {
        $this->commission_type = $commission_type;
        return $this;
    }

    public function getCommissionType()
    {
        return $this->commission_type;
    }

    public function setContactNumber($contact_number)
    {
        $this->contact_number = $contact_number;
        return $this;
    }

    public function getContactNumber()
    {
        return $this->contact_number;
    }

    public function setNationality($nationality)
    {
        $this->nationality = $nationality;
        return $this;
    }

    public function getNationality()
    {
        return $this->nationality;
    }

    public function setDateOfBirth(DateTime $date_of_birth)
    {
        $this->date_of_birth = $date_of_birth;
        return $this;
    }

    public function getDateOfBirth()
    {
        return $this->date_of_birth;
    }



    

    public function setItemsGiven($items_given)
    {
        $this->items_given = $items_given;
        return $this;
    }

    public function getItemsGiven()
    {
        return $this->items_given;
    }

    public function setID($id)
    {
        $this->id = $id;
        return $this;
    }


    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }

    public function getID()
    {
        return $this->id;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getLastLoginText()
    {
        if ($this->getLastLogin() == null)
            return 'Never';
        return $this->getLastLogin()->format('M d, Y - H:m:s');
    }

    public function getEmployee()
    {
        return null;
    }

    public function getEnabledText()
    {
        if ($this->enabled)
            return 'Enabled';
        return 'Disabled';
    }

    public function hasAccess($acl_key)
    {
        
        return true;
    }


    

    public function isEmailNotify()
    {
        return $this->flag_emailnotify;
    }

    public function setEmailNotify($flag)
    {
        $this->flag_emailnotify = $flag;
        return $this;
    }



    public function toData()
    {
        // $groups = array();
        $data = new stdClass();
        $data->id = $this->id;
        $data->username = $this->username;
        $data->email = $this->email;
        $data->enabled = $this->enabled;
        // $data->groups = $groups;

        return $data;
    }
}
