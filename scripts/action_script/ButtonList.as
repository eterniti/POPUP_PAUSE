package action_script
{
   import flash.display.MovieClip;
   
   public class ButtonList
   {
       
      
      private var m_button_list:Array;
      
      private var m_user_data_list:Array;
      
      private var m_state_list:Array;
      
      private var m_button_num:int;
      
      private var m_select_button:int;
      
      private var m_roop:Boolean;
      
      private var m_disable_on_anim:String = "gray_on";
      
      private var m_disable_off_anim:String = "gray_off";
	  
	  //////////
	  private var start_xv2p_button:int;
	  private var num_xv2p_buttons:int;
	  private var num_orig_buttons:int;
	  //////////
      
      public function ButtonList(param1:int, param2:Boolean = true)
      {
         super();
         this.m_button_list = new Array(param1);
         this.m_user_data_list = new Array(param1);
         this.m_state_list = new Array(param1);
         this.m_button_num = 0;
         this.m_select_button = -1;
         this.m_roop = param2;
      }
      
      public function SetExit() : void
      {
         this.m_select_button = -1;
         var _loc1_:* = 0;
         while(_loc1_ < this.m_button_num)
         {
            this.offButton(_loc1_);
            _loc1_++;
         }
      }
      
      public function SetSelectButton(param1:int) : void
      {
         this.m_select_button = param1;
      }
      
      private function offButton(param1:int) : void
      {
         var _loc2_:MovieClip = this.m_button_list[param1];
         _loc2_.gotoAndPlay("off");
      }
      
      private function onButton(param1:int) : void
      {
         var _loc2_:MovieClip = this.m_button_list[param1];
         _loc2_.gotoAndPlay("on");
      }
      
      private function offGrayButton(param1:int) : void
      {
         var _loc2_:MovieClip = this.m_button_list[param1];
         _loc2_.gotoAndPlay(this.m_disable_off_anim);
      }
      
      private function onGrayButton(param1:int) : void
      {
         var _loc2_:MovieClip = this.m_button_list[param1];
         _loc2_.gotoAndPlay(this.m_disable_on_anim);
      }
      
      private function pushButton(param1:int) : void
      {
         var _loc2_:MovieClip = this.m_button_list[param1];
         _loc2_.gotoAndPlay("push");
      }
      
      public function AddButton(param1:MovieClip, param2:int, param3:Boolean = true) : int
      {
         if(this.m_button_num >= this.m_button_list.length)
         {
            return -1;
         }
         var _loc4_:* = this.m_button_num;
         this.m_button_list[_loc4_] = param1;
         this.m_user_data_list[_loc4_] = param2;
         this.m_state_list[_loc4_] = param3;
         this.m_button_num++;
         return _loc4_;
      }
      
      public function ClearButton() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(this.m_button_num > _loc1_)
         {
            this.m_button_list[_loc1_] = 0;
            this.m_user_data_list[_loc1_] = 0;
            this.m_state_list[_loc1_] = false;
            _loc1_++;
         }
         this.m_button_num = 0;
         this.m_select_button = -1;
      }
      
      public function ChangeButton(param1:int) : void
      {
         trace("ChangeButton before : " + param1);
         if(this.m_button_num <= 0)
         {
            return;
         }
         if(param1 == this.m_select_button)
         {
            return;
         }
         if(this.m_select_button >= 0 && this.m_select_button < this.m_button_num)
         {
            if(this.GetState(this.m_select_button))
            {
               this.offButton(this.m_select_button);
            }
            else
            {
               this.offGrayButton(this.m_select_button);
            }
         }
         this.m_select_button = param1;
         trace("ChangeButton after : " + this.m_select_button);
         if(this.m_select_button >= 0 && this.m_select_button < this.m_button_num)
         {
            if(this.GetState(this.m_select_button))
            {
               this.onButton(this.m_select_button);
            }
            else
            {
               this.onGrayButton(this.m_select_button);
            }
         }
      }
	  
	  //////////
	  private function IsXv2Patcher(pos : int) : Boolean
	  {
		if (pos >= start_xv2p_button && pos < (start_xv2p_button+num_xv2p_buttons))
			return true;
			
		return false;
	  }
	  //////////
      
      public function SelectNextButton() : void
      {
         if(this.m_button_num <= 0)
         {
            return;
         }
		 
		 //////////		 
		 if (m_select_button >= 0 && m_select_button < m_button_num && start_xv2p_button >= 0)
		 {		 
			 if (m_select_button >= num_orig_buttons) // current is xv2p button
			 {
				if (m_select_button+1 == m_button_num)
				{
					if (start_xv2p_button == num_orig_buttons)
					{
						ChangeButton(0);
						return;
					}
					else
					{					
						ChangeButton(start_xv2p_button);
						return;
					}
				}
			 }
			 else // current is original button
			 {
				if (m_select_button+1 == start_xv2p_button)
				{				
					ChangeButton(num_orig_buttons);
					return;
				}
				else if (m_select_button+1 == num_orig_buttons)
				{
					if (IsXv2Patcher(0))
					{
						ChangeButton(num_orig_buttons);		
						return;
					}
					else
					{
						ChangeButton(0);
						return;
					}
				}
			 }
	     }		 
		 //////////
		 
         var _loc1_:* = this.m_select_button + 1;
         if(_loc1_ >= this.m_button_num)
         {
            if(!this.m_roop)
            {
               return;
            }
            _loc1_ = 0;
         }
         this.ChangeButton(_loc1_);
      }
      
      public function SelectPrevButton() : void
      {
         if(this.m_button_num <= 0)
         {
            return;
         }
		 
		 //////////
		 if (m_select_button >= 0 && m_select_button < m_button_num && start_xv2p_button >= 0)
		 {
			var last_xv2p:int = start_xv2p_button+num_xv2p_buttons-1;
			
			if (m_select_button >= num_orig_buttons) // current is x2vp button
			{
				if (m_select_button == num_orig_buttons)
				{
					if (start_xv2p_button == 0)
					{
						ChangeButton(num_orig_buttons-1);
						return;
					}
					
					ChangeButton(start_xv2p_button-1);
					return
				}
			}
			else // current is original button
			{
				if (start_xv2p_button == m_select_button)
				{			
					ChangeButton(m_button_num-1);
					return;						
				}
				else if (m_select_button == 0)
				{
					if (last_xv2p != m_button_num-1)
					{
						ChangeButton(num_orig_buttons-1);
						return;
					}
				}
			}
		 }
		 //////////		 
		 
         var _loc1_:* = this.m_select_button - 1;
         if(_loc1_ < 0)
         {
            if(!this.m_roop)
            {
               return;
            }
            _loc1_ = this.m_button_num - 1;
         }
         this.ChangeButton(_loc1_);
      }
      
      public function PushButton() : void
      {
         if(this.m_button_num <= 0)
         {
            return;
         }
         if(this.m_select_button < 0 && this.m_button_num <= this.m_select_button)
         {
            return;
         }
         this.pushButton(this.m_select_button);
      }
      
      public function SelectNextButtonEx() : void
      {
         var _loc1_:* = this.GetSelectButton();
         var _loc2_:int = 0;
         while(_loc2_ < this.m_button_num)
         {
            this.SelectNextButton();
            if(this.GetSelectState())
            {
               break;
            }
            _loc2_++;
         }
         if(!this.GetSelectState())
         {
            this.ChangeButton(_loc1_);
         }
      }
      
      public function SelectPrevButtonEx() : void
      {
         var _loc1_:* = this.GetSelectButton();
         var _loc2_:int = 0;
         while(_loc2_ < this.m_button_num)
         {
            this.SelectPrevButton();
            if(this.GetSelectState())
            {
               break;
            }
            _loc2_++;
         }
         if(!this.GetSelectState())
         {
            this.ChangeButton(_loc1_);
         }
      }
      
      public function PushButtonEx() : Boolean
      {
         if(this.m_button_num <= 0)
         {
            return false;
         }
         if(this.m_select_button < 0 && this.m_button_num <= this.m_select_button)
         {
            return false;
         }
         if(this.GetState(this.m_select_button))
         {
            this.pushButton(this.m_select_button);
            return true;
         }
         return false;
      }
      
      public function GetButton(param1:int) : MovieClip
      {
         if(param1 < 0 || this.m_button_num <= param1)
         {
            return null;
         }
         return this.m_button_list[param1];
      }
      
      public function GetSelectButton() : int
      {
         if(this.m_button_num <= 0)
         {
            return -1;
         }
         return this.m_select_button;
      }
      
      public function SearchButton(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         var _loc4_:int = param2;
         while(this.m_button_num > _loc4_)
         {
            if(param1 != this.m_user_data_list[_loc4_])
            {
               _loc4_++;
               continue;
            }
            _loc3_ = _loc4_;
            break;
         }
         return _loc3_;
      }
      
      public function SetUserData(param1:int, param2:int) : void
      {
         if(param1 < 0 || param1 >= this.m_button_num)
         {
            return;
         }
         this.m_user_data_list[param1] = param2;
      }
      
      public function GetUserData(param1:int) : int
      {
         if(param1 < 0 || param1 >= this.m_button_num)
         {
            return -1;
         }
         return this.m_user_data_list[param1];
      }
      
      public function GetSelectUserData() : int
      {
         return this.GetUserData(this.m_select_button);
      }
      
      public function setGrayButtonAnimation(param1:String, param2:String) : void
      {
         this.m_disable_on_anim = param1;
         this.m_disable_off_anim = param2;
      }
      
      public function SetState(param1:int, param2:Boolean) : void
      {
         if(param1 < 0 || param1 >= this.m_button_num)
         {
            return;
         }
         if(this.m_state_list[param1] != param2)
         {
            if(param1 == this.m_select_button)
            {
               if(param2)
               {
                  this.onButton(param1);
               }
               else
               {
                  this.onGrayButton(param1);
               }
            }
            else if(param2)
            {
               this.offButton(param1);
            }
            else
            {
               this.offGrayButton(param1);
            }
         }
         this.m_state_list[param1] = param2;
      }
      
      public function GetState(param1:int) : Boolean
      {
         if(param1 < 0 || param1 >= this.m_button_num)
         {
            return false;
         }
         return this.m_state_list[param1];
      }
      
      public function GetSelectState() : Boolean
      {
         return this.GetState(this.m_select_button);
      }
      
      public function GetButtonNum() : int
      {
         return this.m_button_num;
      }
	  
	  //////////
	  public function SetXV2PInfo(start_pos : int, num:int, num_orig:int) : void
	  {
		start_xv2p_button = start_pos;
		num_xv2p_buttons = num;
		num_orig_buttons = num_orig;
	  }
	  //////////
   }
}
