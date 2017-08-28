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
 * @ORM\Table(name="gist_pos_trans")
 */

class POSTransactions
{


    use HasGeneratedID;
    use TrackCreate;



    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $product_id;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $transaction_total;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $trnasaction_balance;

    /** @ORM\Column(type="string", length=150, nullable=true) */
    protected $customer_id;




    public function __construct()
    {
        $this->initTrackCreate();
    }

    
    public function toData()
    {
        $data = new \stdClass();
        $this->dataHasGeneratedID($data);
        $this->dataTrackCreate($data);
        return $data;
    }

    /**
     * Set productId
     *
     * @param string $productId
     *
     * @return POSTransactions
     */
    public function setProductId($productId)
    {
        $this->product_id = $productId;

        return $this;
    }

    /**
     * Get productId
     *
     * @return string
     */
    public function getProductId()
    {
        return $this->product_id;
    }

    /**
     * Set transactionTotal
     *
     * @param string $transactionTotal
     *
     * @return POSTransactions
     */
    public function setTransactionTotal($transactionTotal)
    {
        $this->transaction_total = $transactionTotal;

        return $this;
    }

    /**
     * Get transactionTotal
     *
     * @return string
     */
    public function getTransactionTotal()
    {
        return $this->transaction_total;
    }

    /**
     * Set trnasactionBalance
     *
     * @param string $trnasactionBalance
     *
     * @return POSTransactions
     */
    public function setTrnasactionBalance($trnasactionBalance)
    {
        $this->trnasaction_balance = $trnasactionBalance;

        return $this;
    }

    /**
     * Get trnasactionBalance
     *
     * @return string
     */
    public function getTrnasactionBalance()
    {
        return $this->trnasaction_balance;
    }

    /**
     * Set customerId
     *
     * @param string $customerId
     *
     * @return POSTransactions
     */
    public function setCustomerId($customerId)
    {
        $this->customer_id = $customerId;

        return $this;
    }

    /**
     * Get customerId
     *
     * @return string
     */
    public function getCustomerId()
    {
        return $this->customer_id;
    }
}
