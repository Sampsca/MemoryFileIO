;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; NumTypes ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Name      Size    Alias ;;;;;;;;;;;;
;;;;;;;;;;;; UInt      4       DWORD ;;;;;;;;;;;;
;;;;;;;;;;;; Int       4       Long  ;;;;;;;;;;;;
;;;;;;;;;;;; Int64     8             ;;;;;;;;;;;;
;;;;;;;;;;;; Short     2             ;;;;;;;;;;;;
;;;;;;;;;;;; UShort    2       WORD  ;;;;;;;;;;;;
;;;;;;;;;;;; Char      1             ;;;;;;;;;;;;
;;;;;;;;;;;; UChar     1       BYTE  ;;;;;;;;;;;;
;;;;;;;;;;;; Double    8             ;;;;;;;;;;;;
;;;;;;;;;;;; Float     4             ;;;;;;;;;;;;
;;;;;;;;;;;; Ptr       A_PtrSize     ;;;;;;;;;;;;
;;;;;;;;;;;; UPtr      A_PtrSize     ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Declare class:
Class MemoryFileIO{
	__New(ByRef InputVar, VarSize:=""){
		If InputVar is not integer ; Is a Variable not an Address
			this.Address:=&InputVar
		Else
			this.Address:=InputVar
		this.Pointer:=0
		this.AllocatedBuffer:=(VarSize=""?VarSetCapacity(InputVar):VarSize)
		this.AtEOF:=0
		this.Encoding:=A_FileEncoding
		}
	__Get(aName){
		If (aName="Length")
			Return this.AllocatedBuffer
		Else If (aName="Position"||aName="Pos")
			Return this.Pointer
		}
	__Set(aName,Val){
		If (aName="Length")
			Return this.AllocatedBuffer ; Updating the internally stored length of the input variable's allocated memory is not supported.
		Else If (aName="Position"||aName="Pos"){
			If (Val)
				Return this.Pointer:=Val
			}
		}
	ReadUInt(){
		Num:=NumGet(this.Address+0, this.Pointer, "UInt"), this.Pointer+=4
		Return Num
	}
	ReadDWORD(){
		Num:=NumGet(this.Address+0, this.Pointer, "UInt"), this.Pointer+=4
		Return Num
	}
	ReadInt(){
		Num:=NumGet(this.Address+0, this.Pointer, "Int"), this.Pointer+=4
		Return Num
	}
	ReadLong(){
		Num:=NumGet(this.Address+0, this.Pointer, "Int"), this.Pointer+=4
		Return Num
	}
	ReadInt64(){
		Num:=NumGet(this.Address+0, this.Pointer, "Int64"), this.Pointer+=8
		Return Num
	}
	ReadShort(){
		Num:=NumGet(this.Address+0, this.Pointer, "Short"), this.Pointer+=2
		Return Num
	}
	ReadUShort(){
		Num:=NumGet(this.Address+0, this.Pointer, "UShort"), this.Pointer+=2
		Return Num
	}
	ReadWORD(){
		Num:=NumGet(this.Address+0, this.Pointer, "UShort"), this.Pointer+=2
		Return Num
	}
	ReadChar(){
		Num:=NumGet(this.Address+0, this.Pointer, "Char"), this.Pointer++
		Return Num
	}
	ReadUChar(){
		Num:=NumGet(this.Address+0, this.Pointer, "UChar"), this.Pointer++
		Return Num
	}
	ReadBYTE(){
		Num:=NumGet(this.Address+0, this.Pointer, "UChar"), this.Pointer++
		Return Num
	}
	ReadDouble(){
		Num:=NumGet(this.Address+0, this.Pointer, "Double"), this.Pointer+=8
		Return Num
	}
	ReadFloat(){
		Num:=NumGet(this.Address+0, this.Pointer, "Float"), this.Pointer+=4
		Return Num
	}
	ReadPtr(){
		Num:=NumGet(this.Address+0, this.Pointer, "Ptr"), this.Pointer+=A_PtrSize
		Return Num
	}
	ReadUPtr(){
		Num:=NumGet(this.Address+0, this.Pointer, "UPtr"), this.Pointer+=A_PtrSize
		Return Num
	}
	WriteUInt(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UInt"), this.Pointer+=4
		Return 4
	}
	WriteDWORD(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UInt"), this.Pointer+=4
		Return 4
	}
	WriteInt(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Int"), this.Pointer+=4
		Return 4
	}
	WriteLong(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Int"), this.Pointer+=4
		Return 4
	}
	WriteInt64(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Int64"), this.Pointer+=8
		Return 8
	}
	WriteShort(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Short"), this.Pointer+=2
		Return 2
	}
	WriteUShort(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UShort"), this.Pointer+=2
		Return 2
	}
	WriteWORD(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UShort"), this.Pointer+=2
		Return 2
	}
	WriteChar(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Char"), this.Pointer++
		Return 1
	}
	WriteUChar(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UChar"), this.Pointer++
		Return 1
	}
	WriteBYTE(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UChar"), this.Pointer++
		Return 1
	}
	WriteDouble(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Double"), this.Pointer+=8
		Return 8
	}
	WriteFloat(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Float"), this.Pointer+=4
		Return 4
	}
	WritePtr(Number){
		NumPut(Number, this.Address+0, this.Pointer, "Ptr"), this.Pointer+=A_PtrSize
		Return A_PtrSize
	}
	WriteUPtr(Number){
		NumPut(Number, this.Address+0, this.Pointer, "UPtr"), this.Pointer+=A_PtrSize
		Return A_PtrSize
	}
	Tell(){
		Return this.Pointer
	}
	Read(Length:="", Encoding:=""){
		If (Encoding="")
			Encoding:=this.Encoding
		CharLen:=((encoding="utf-16"||encoding="cp1200")?2:1) ; calculate length of each character in bytes
		If (Length="")
			Length:=this.AllocatedBuffer/CharLen ; convert length of AllocatedBuffer from bytes to chars
		Length:=(this.Pointer+Length*CharLen>this.AllocatedBuffer?(this.AllocatedBuffer-this.Pointer)/CharLen:Length)
		Length:=(Length<0?0:Length)
		Str:=StrGet(this.Address+this.Pointer, Length, Encoding)
		this.Seek(Length*CharLen,1)
		Return Str
	}
	Write(String, Length:="", Encoding:=""){
		If (Encoding="")
			Encoding:=this.Encoding
		CharLen:=((encoding="utf-16"||encoding="cp1200")?2:1) ; calculate length of each character in bytes
		If (Length="")
			Length:=StrLen(String)
		Length:=(this.Pointer+Length*CharLen>this.AllocatedBuffer?(this.AllocatedBuffer-this.Pointer)/CharLen:Length)
		Length:=(Length<0?0:Length)
		NumWritten:=StrPut(SubStr(String,1,Length),this.Address+this.Pointer,Length,Encoding)
		this.Seek(NumWritten*CharLen,1)
		Return NumWritten*CharLen
	}
	RawRead(ByRef VarOrAddress,Bytes){
		Bytes:=(this.Pointer+Bytes>this.AllocatedBuffer?this.AllocatedBuffer-this.Pointer:Bytes)
		If VarOrAddress is not integer ; Is a Variable not an Address
			{
			If (VarSetCapacity(VarOrAddress)<Bytes)
				VarSetCapacity(VarOrAddress,Bytes)
			this._BCopy(this.Address+this.Pointer,&VarOrAddress,Bytes)
			}
		Else ; Is an Address not a Variable
			this._BCopy(this.Address+this.Pointer,VarOrAddress,Bytes)
		this.Seek(Bytes,1)
		Return Bytes
	}
	RawWrite(ByRef VarOrAddress,Bytes){
		Bytes:=(this.Pointer+Bytes>this.AllocatedBuffer?this.AllocatedBuffer-this.Pointer:Bytes)
		If VarOrAddress is not integer ; Is a Variable not an Address
			{
			If (VarSetCapacity(VarOrAddress)<Bytes)
				Bytes:=VarSetCapacity(VarOrAddress) ; Ensures Bytes is not greater than the size of VarOrAddress
			this._BCopy(&VarOrAddress,this.Address+this.Pointer,Bytes)
			}
		Else ; Is an Address not a Variable
			this._BCopy(VarOrAddress,this.Address+this.Pointer,Bytes)
		this.Seek(Bytes,1)
		Return Bytes
	}
	Seek(Distance, Origin:=""){
		If (Origin="")
			Origin:=(Distance<1?2:0)
		If (Origin=0)
			this.Pointer:=Distance
		Else If (Origin=1)
			this.Pointer+=Distance
		Else If (Origin=2)
			this.Pointer:=this.AllocatedBuffer+Distance
		If (this.Pointer<1)
			{
			this.Pointer:=0
			this.AtEOF:=0
			Return -1 ; Returns -1 if Pointer was moved before beginning of file
			}
		Else If (this.Pointer>=this.AllocatedBuffer)
			{
			this.Pointer:=this.AllocatedBuffer
			this.AtEOF:=1
			If (this.Pointer>this.AllocatedBuffer)
				Return 2 ; Returns 2 if EoF was passed
			Else
				Return 1 ; Returns 1 if EoF was reached
			}
		Else
			{
			this.AtEOF:=0
			Return 1 ; Returns 1 if Pointer is still in bounds
			}
	}
	_BCopy(Source,Destination,Length){
		DllCall("RtlMoveMemory","Ptr",Destination,"Ptr",Source,"Ptr",Length) ;https://msdn.microsoft.com/en-us/library/windows/hardware/ff562030(v=vs.85).aspx
	}
}