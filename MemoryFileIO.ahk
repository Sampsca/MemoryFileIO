;////////////////////////////////////////////////
;///////////// Class MemoryFileIO ///////////////
;////////////////////////////////////////////////
;;; Provides Input/Output File Object syntax for in-memory files.
;;; Usage is very similar to the File Object syntax: 
;;; 	https://autohotkey.com/docs/objects/File.htm
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; New MemoryFileIO(InputVar) ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Creates a new instance of the class.  Pass it the variable
;;; you will be performing file I/O operations on.
;;; The MemoryFileIO class will bound all reads/writes to the
;;; memory already allocated to the variable upon creating
;;; the new instance of the class.  Use VarSetCapacity()
;;; to initialize enough memory for your needs BEFORE creating
;;; a new MemoryFileIO instance with your variable.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Read ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Reads a string of characters from the file and advances the file pointer.
;;; Syntax:  String := Instance.Read([Characters, Encoding = None])
;;; Characters:	The maximum number of characters to read. If omitted, 
;;;		the rest of the file is read and returned as one string.
;;; Encoding: The source encoding; for example, "UTF-8", "UTF-16" or "CP936".
;;;		Specify an empty string or "CP0" to use the system default ANSI code page.
;;; Returns: A string.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; Write ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Writes a string of characters to the file and advances the file pointer.
;;; Syntax:  NumWritten := Instance.Write(String [, Characters, Encoding])
;;; String: A string.
;;; Characters: The maximum number of characters to write. If omitted, 
;;;		all of String is written.
;;; Encoding: The target encoding; for example, "UTF-8", "UTF-16" or "CP936".
;;;		Specify an empty string or "CP0" to use the system default ANSI code page.
;;; Returns: The number of bytes (not characters) that were written.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; ReadNum ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Reads a number from the file and advances the file pointer.
;;; Syntax:  Num := Instance.ReadNumType()
;;; NumType: One of the following specified directly as part of the method name:
;;; 	UInt, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr or UPtr
;;; Returns: A number if successful, otherwise an empty string.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; WriteNum ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Writes a number to the file and advances the file pointer.
;;; Syntax:  Instance.WriteNumType(Num)
;;; NumType: One of the following specified directly as part of the method name:
;;; 	UInt, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr or UPtr
;;; Num: A number.
;;; Returns: The number of bytes that were written. For instance, WriteUInt 
;;; 	returns 4 if successful.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; RawRead ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Copies raw binary data from the file to another memory address or variable.
;;; 	If a var is specified, it is expanded automatically when necessary.
;;; 	If a var is specified that contains only an integer, that integer is 
;;; 	considered the address.
;;; Syntax:  Instance.RawRead(VarOrAddress, Bytes)
;;; VarOrAddress: A variable or memory address to which the data will be copied.
;;; Bytes: The maximum number of bytes to read.
;;; Returns: The number of bytes that were read.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; RawWrite ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Write raw binary data to the file from another memory address or variable.
;;; 	If a var is specified that contains only an integer, that integer is 
;;; 	considered the address.  If VarOrAddress is a variable and Bytes is
;;; 	greater than the capacity of VarOrAddress, Bytes is reduced to the capacity
;;; 	of VarOrAddress.
;;; Syntax:  Instance.RawWrite(VarOrAddress, Bytes)
;;; VarOrAddress: A variable containing the data or the address of the data 
;;; 	in memory.
;;; Bytes: The number of bytes to write.
;;; Returns: The number of bytes that were written.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Seek ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Moves the file pointer.
;;; Syntax:	Instance.Seek(Distance [, Origin])
;;; 		Instance.Position := Distance
;;; 		Instance.Pos := Distance
;;; Distance: Distance to move, in bytes. Lower values are closer to the 
;;; 	beginning of the file.
;;; Origin: Starting point for the file pointer move. Must be one of the following:
;;; 	0 (SEEK_SET): Beginning of the file. Distance must be zero or greater.
;;; 	1 (SEEK_CUR): Current position of the file pointer.
;;; 	2 (SEEK_END): End of the file. Distance should usually be negative.
;;; 	If omitted, Origin defaults to SEEK_END when Distance is negative 
;;; 	and SEEK_SET otherwise.
;;; Returns: A non-zero value if successful, otherwise zero. Specifically:
;;; 	-1 : Pointer was instructed to moved before beginning of file.
;;; 		 Automatically moved to beginning of file instead.
;;; 	1  : Pointer is still in bounds or if EoF was reached.
;;; 	2  : Pointer was instructed to move past EoF.
;;; 		 Automatically moved to EoF instead.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Tell ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Syntax:	Pos := Instance.Tell()
;;; 		Pos := Instance.Position
;;; 		Pos := Instance.Pos
;;; Returns: The current position of the file pointer, where 0 is the 
;;; 	beginning of the file.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; Length ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Retrieves the size of the file.  Setting a new size is not supported.
;;; Syntax:	FileSize := Instance.Length
;;; Returns: 	The size of the file, in bytes.
;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; AtEOF ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Syntax:	IsAtEOF := Instance.AtEOF
;;; Returns: A non-zero value if the file pointer has reached the 
;;; 	end of the file, otherwise zero.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; Encoding ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Retrieves or sets the text encoding used by this method.
;;; Encoding defaults to A_FileEncoding which defaults to the system 
;;; 	default ANSI code page ("CP0") if not specified.
;;; Syntax:	Encoding := File.Encoding
;;; 		File.Encoding := Encoding
;;; Encoding: 	A numeric code page identifier (see MSDN) or 
;;; 	one of the following strings:
;;; 	UTF-8: Unicode UTF-8, equivalent to CP65001.
;;; 	UTF-16: Unicode UTF-16 with little endian byte order, equivalent to CP1200.
;;; 	CPnnn: a code page with numeric identifier nnn.
;;; Setting Encoding never causes a BOM to be added or removed.
;;; 
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
		;~ MsgBox, , MemoryFileIO, % this.AllocatedBuffer
		this.AtEOF:=0
		this.Encoding:=A_FileEncoding
		}
	__Call(aName,Val1:=""){
		If (aName="ReadUInt"||aName="ReadDWORD")
            Return this._ReadNumType("UInt",4)
		Else If (aName="ReadInt"||aName="ReadLong")
			Return this._ReadNumType("Int",4)
		Else If (aName="ReadInt64")
			Return this._ReadNumType("Int64",8)
		Else If (aName="ReadShort")
			Return this._ReadNumType("Short",2)
		Else If (aName="ReadUShort"||aName="ReadWORD")
			Return this._ReadNumType("UShort",2)
		Else If (aName="ReadChar")
			Return this._ReadNumType("Char",1)
		Else If (aName="ReadUChar"||aName="ReadBYTE")
			Return this._ReadNumType("UChar",1)
		Else If (aName="ReadDouble")
			Return this._ReadNumType("Double",8)
		Else If (aName="ReadFloat")
			Return this._ReadNumType("Float",4)
		Else If (aName="ReadPtr")
			Return this._ReadNumType("Ptr",A_PtrSize)
		Else If (aName="ReadUPtr")
			Return this._ReadNumType("UPtr",A_PtrSize)
		Else If (aName="WriteUInt"||aName="WriteDWORD")
            Return this._WriteNumType(Val1,"UInt",4)
		Else If (aName="WriteInt"||aName="WriteLong")
			Return this._WriteNumType(Val1,"Int",4)
		Else If (aName="WriteInt64")
			Return this._WriteNumType(Val1,"Int64",8)
		Else If (aName="WriteShort")
			Return this._WriteNumType(Val1,"Short",2)
		Else If (aName="WriteUShort"||aName="WriteWORD")
			Return this._WriteNumType(Val1,"UShort",2)
		Else If (aName="WriteChar")
			Return this._WriteNumType(Val1,"Char",1)
		Else If (aName="WriteUChar"||aName="WriteBYTE")
			Return this._WriteNumType(Val1,"UChar",1)
		Else If (aName="WriteDouble")
			Return this._WriteNumType(Val1,"Double",8)
		Else If (aName="WriteFloat")
			Return this._WriteNumType(Val1,"Float",4)
		Else If (aName="WritePtr")
			Return this._WriteNumType(Val1,"Ptr",A_PtrSize)
		Else If (aName="WriteUPtr")
			Return this._WriteNumType(Val1,"UPtr",A_PtrSize)
		Else If (aName="Tell")
			Return this.Pointer
		}
	__Get(aName){
		If (aName="Position"||aName="Pos")
			Return this.Pointer
		Else If (aName="Length")
			Return this.AllocatedBuffer
		}
	__Set(aName,Val){
		If (aName="Length") ; ||aName="AllocatedBuffer"
			Return this.AllocatedBuffer ; Updating the internally stored length of the input variable's allocated memory is not supported.
		Else If (aName="Position"||aName="Pos"){
			If (Val)
				Return this.Seek(Val,0)
			}
		}
	_ReadNumType(Type,Length){
		If (this.pointer+Length>this.AllocatedBuffer)
			Return
		Num:=NumGet(this.Address+0, this.Pointer, Type)
		this.Seek(Length,1)
		Return Num
	}
	_WriteNumType(Number,Type,Length){
		If (this.pointer+Length>this.AllocatedBuffer)
			Return 0
		Val:=NumPut(Number, this.Address+0, this.Pointer, Type)
		this.Seek(Length,1)
		Return (Val<>""?Length:0)
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