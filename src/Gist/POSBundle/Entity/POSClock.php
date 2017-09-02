<?php

namespace Gist\POSBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

use Gist\CoreBundle\Template\Entity\HasGeneratedID;
use Gist\CoreBundle\Template\Entity\TrackCreate;

use DateTime;
use stdClass;

/**
 * @ORM\Entity
 * @ORM\Table(name="gist_pos_clock")
 */

class POSClock
{


    use HasGeneratedID;
    // use TrackCreate;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $user_id;

    /** @ORM\Column(type="date") */
    protected $date;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $type;





    public function __construct()
    {
        // $this->initTrackCreate();
    }

    
    public function toData()
    {
        $data = new \stdClass();
        $this->dataHasGeneratedID($data);
        // $this->dataTrackCreate($data);
        return $data;
    }


    /**
     * Set userId
     *
     * @param string $userId
     *
     * @return POSClock
     */
    public function setUserId($userId)
    {
        $this->user_id = $userId;

        return $this;
    }

    /**
     * Get userId
     *
     * @return string
     */
    public function getUserId()
    {
        return $this->user_id;
    }

    /**
     * Set date
     *
     * @param \DateTime $date
     *
     * @return POSClock
     */
    public function setDate($date)
    {
        $this->date = $date;

        return $this;
    }

    /**
     * Get date
     *
     * @return \DateTime
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * Set type
     *
     * @param string $type
     *
     * @return POSClock
     */
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * Get type
     *
     * @return string
     */
    public function getType()
    {
        return $this->type;
    }
}
