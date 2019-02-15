;////////////////////////////////////////////////
;///////////// Class MemoryFileIO ///////////////
;////////////////////////////////////////////////
;;; Provides Input/Output File Object syntax for in-memory files.
;;; Usage is very similar to the File Object syntax: 
;;; 	https://autohotkey.com/docs/objects/File.htm
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; New MemoryFileIO() ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Creates a new instance of the class.
;;; Syntax:  Instance := New MemoryFileIO(InputVar, [VarSize, DefaultEncoding])
;;; Pass it the variable (directly or by address) you will be performing
;;; 	file I/O operations on.  DefaultEncoding defaults to A_FileEncoding.
;;; The MemoryFileIO class will bound all reads/writes to the
;;; 	memory already allocated to the variable upon creating
;;; 	the new instance of the class.  Use VarSetCapacity()
;;; 	to initialize enough memory for your needs BEFORE creating
;;; 	a new MemoryFileIO instance with your variable.
;;; This class will raise an exception on error.
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
;;; 	UInt, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr, UPtr
;;; 	DWORD, Long, WORD, or BYTE
;;; Returns: A number if successful.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; WriteNum ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Writes a number to the file and advances the file pointer.
;;; Syntax:  Instance.WriteNumType(Num)
;;; NumType: One of the following specified directly as part of the method name:
;;; 	UInt, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr, UPtr
;;; 	DWORD, Long, WORD, or BYTE
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
;;; 	Instance.Position := Distance
;;; 	Instance.Pos := Distance
;;; Distance: Distance to move, in bytes. Lower values are closer to the 
;;; 	beginning of the file.
;;; Origin: Starting point for the file pointer move. Must be one of the following:
;;; 	0 (SEEK_SET): Beginning of the file. Distance must be zero or greater.
;;; 	1 (SEEK_CUR): Current position of the file pointer.
;;; 	2 (SEEK_END): End of the file. Distance should usually be negative.
;;; 	If omitted, Origin defaults to SEEK_END when Distance is negative 
;;; 	and SEEK_SET otherwise.
;;; Returns one of the following values:
;;; 	-1 : Pointer was instructed to move before beginning of file.
;;; 		 Automatically moved to beginning of file instead.
;;; 	1  : Pointer is still in bounds or if EoF was reached.
;;; 	2  : Pointer was instructed to move past EoF.
;;; 		 Automatically moved to EoF instead.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Tell ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Syntax:	Pos := Instance.Tell()
;;; 	Pos := Instance.Position
;;; 	Pos := Instance.Pos
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
;;; Syntax:	Encoding := Instance.Encoding
;;; 		Instance.Encoding := Encoding
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
	__New(ByRef InputVar, VarSize:="", DefaultEncoding:=""){
		If InputVar is not integer ; Is a Variable not an Address
			this.Address:=&InputVar
		Else
			this.Address:=InputVar
		this.Position:=0
		this.Length:=(VarSize=""?VarSetCapacity(InputVar):VarSize)
		this.AtEOF:=0
		this.Encoding:=(DefaultEncoding=""?A_FileEncoding:DefaultEncoding)
		}
	ReadUInt(){
		If (this.Position+4>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UInt"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=4
		Return Num
	}
	ReadDWORD(){
		If (this.Position+4>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UInt"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=4
		Return Num
	}
	ReadInt(){
		If (this.Position+4>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Int"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=4
		Return Num
	}
	ReadLong(){
		If (this.Position+4>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Int"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=4
		Return Num
	}
	ReadInt64(){
		If (this.Position+8>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Int64"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=8
		Return Num
	}
	ReadShort(){
		If (this.Position+2>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Short"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=2
		Return Num
	}
	ReadUShort(){
		If (this.Position+2>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UShort"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=2
		Return Num
	}
	ReadWORD(){
		If (this.Position+2>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UShort"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=2
		Return Num
	}
	ReadChar(){
		If (this.Position+1>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Char"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position++
		Return Num
	}
	ReadUChar(){
		If (this.Position+1>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UChar"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position++
		Return Num
	}
	ReadBYTE(){
		If (this.Position+1>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UChar"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position++
		Return Num
	}
	ReadDouble(){
		If (this.Position+8>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Double"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=8
		Return Num
	}
	ReadFloat(){
		If (this.Position+4>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Float"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=4
		Return Num
	}
	ReadPtr(){
		If (this.Position+A_PtrSize>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "Ptr"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=A_PtrSize
		Return Num
	}
	ReadUPtr(){
		If (this.Position+A_PtrSize>this.Length) OR ((Num:=NumGet(this.Address+0, this.Position, "UPtr"))="")
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory read.", extra: "Val='" Num "' at offset " this.Position " of " this.Length-1}
		this.Position+=A_PtrSize
		Return Num
	}
	WriteUInt(Number){
		If (Number="") OR (this.Position+4>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UInt"), this.Position+=4
		Return 4
	}
	WriteDWORD(Number){
		If (Number="") OR (this.Position+4>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UInt"), this.Position+=4
		Return 4
	}
	WriteInt(Number){
		If (Number="") OR (this.Position+4>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Int"), this.Position+=4
		Return 4
	}
	WriteLong(Number){
		If (Number="") OR (this.Position+4>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Int"), this.Position+=4
		Return 4
	}
	WriteInt64(Number){
		If (Number="") OR (this.Position+8>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Int64"), this.Position+=8
		Return 8
	}
	WriteShort(Number){
		If (Number="") OR (this.Position+2>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Short"), this.Position+=2
		Return 2
	}
	WriteUShort(Number){
		If (Number="") OR (this.Position+2>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UShort"), this.Position+=2
		Return 2
	}
	WriteWORD(Number){
		If (Number="") OR (this.Position+2>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UShort"), this.Position+=2
		Return 2
	}
	WriteChar(Number){
		If (Number="") OR (this.Position+1>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Char"), this.Position++
		Return 1
	}
	WriteUChar(Number){
		If (Number="") OR (this.Position+1>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UChar"), this.Position++
		Return 1
	}
	WriteBYTE(Number){
		If (Number="") OR (this.Position+1>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UChar"), this.Position++
		Return 1
	}
	WriteDouble(Number){
		If (Number="") OR (this.Position+8>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Double"), this.Position+=8
		Return 8
	}
	WriteFloat(Number){
		If (Number="") OR (this.Position+4>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Float"), this.Position+=4
		Return 4
	}
	WritePtr(Number){
		If (Number="") OR (this.Position+A_PtrSize>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "Ptr"), this.Position+=A_PtrSize
		Return A_PtrSize
	}
	WriteUPtr(Number){
		If (Number="") OR (this.Position+A_PtrSize>this.Length)
			throw { what: (IsFunc(A_ThisFunc)?"function: " A_ThisFunc "()":"") A_Tab (IsLabel(A_ThisLabel)?"label: " A_ThisLabel:""), file: A_LineFile, line: A_LineNumber, message: "Invalid memory write.", extra: "Number='" Number "' at offset " this.Position " of " this.Length-1}
		NumPut(Number, this.Address+0, this.Position, "UPtr"), this.Position+=A_PtrSize
		Return A_PtrSize
	}
	Tell(){
		Return this.Position
	}
	Position(){
		Return this.Position
	}
	Pos(){
		Return this.Position
	}
	Length(){
		Return this.Length
	}
	Read(Length:="", Encoding:=""){
		If (Encoding="")
			Encoding:=this.Encoding
		CharLen:=((encoding="utf-16"||encoding="cp1200")?2:1) ; calculate length of each character in bytes
		If (Length="")
			Length:=this.Length/CharLen ; convert length of Length from bytes to chars
		Length:=(this.Position+Length*CharLen>this.Length?(this.Length-this.Position)/CharLen:Length)
		Length:=(Length<0?0:Length)
		Str:=StrGet(this.Address+this.Position, Length, Encoding)
		this.Seek(Length*CharLen,1)
		Return Str
	}
	Write(String, Length:="", Encoding:=""){
		If (Encoding="")
			Encoding:=this.Encoding
		CharLen:=((encoding="utf-16"||encoding="cp1200")?2:1) ; calculate length of each character in bytes
		If (Length="")
			Length:=StrLen(String)
		Length:=(this.Position+Length*CharLen>this.Length?(this.Length-this.Position)/CharLen:Length)
		Length:=(Length<0?0:Length)
		NumWritten:=StrPut(SubStr(String,1,Length),this.Address+this.Position,Length,Encoding)
		this.Seek(NumWritten*CharLen,1)
		Return NumWritten*CharLen
	}
	RawRead(ByRef VarOrAddress,Bytes){
		Bytes:=(this.Position+Bytes>this.Length?this.Length-this.Position:Bytes)
		If VarOrAddress is not integer ; Is a Variable not an Address
			{
			If (VarSetCapacity(VarOrAddress)<Bytes)
				VarSetCapacity(VarOrAddress,Bytes)
			this._BCopy(this.Address+this.Position,&VarOrAddress,Bytes)
			}
		Else ; Is an Address not a Variable
			this._BCopy(this.Address+this.Position,VarOrAddress,Bytes)
		this.Seek(Bytes,1)
		Return Bytes
	}
	RawWrite(ByRef VarOrAddress,Bytes){
		Bytes:=(this.Position+Bytes>this.Length?this.Length-this.Position:Bytes)
		If VarOrAddress is not integer ; Is a Variable not an Address
			{
			If (VarSetCapacity(VarOrAddress)<Bytes)
				Bytes:=VarSetCapacity(VarOrAddress) ; Ensures Bytes is not greater than the size of VarOrAddress
			this._BCopy(&VarOrAddress,this.Address+this.Position,Bytes)
			}
		Else ; Is an Address not a Variable
			this._BCopy(VarOrAddress,this.Address+this.Position,Bytes)
		this.Seek(Bytes,1)
		Return Bytes
	}
	Seek(Distance, Origin:=""){
		If (Origin="")
			Origin:=(Distance<1?2:0)
		If (Origin=0)
			this.Position:=Distance
		Else If (Origin=1)
			this.Position+=Distance
		Else If (Origin=2)
			this.Position:=this.Length+Distance
		If (this.Position<1)
			{
			this.Position:=0
			this.AtEOF:=0
			Return -1 ; Returns -1 if Position was moved before beginning of file
			}
		Else If (this.Position>=this.Length)
			{
			this.Position:=this.Length
			this.AtEOF:=1
			If (this.Position>this.Length)
				Return 2 ; Returns 2 if EoF was passed
			Else
				Return 1 ; Returns 1 if EoF was reached
			}
		Else
			{
			this.AtEOF:=0
			Return 1 ; Returns 1 if Position is still in bounds
			}
	}
	_BCopy(Source,Destination,Length){
		DllCall("RtlMoveMemory","Ptr",Destination,"Ptr",Source,"UInt",Length) ;https://msdn.microsoft.com/en-us/library/windows/hardware/ff562030(v=vs.85).aspx
	}
}