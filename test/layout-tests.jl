const LAYOUT_TESTS = [
"""@cstruct T {
}""",

"""@cstruct T {
	c::Cchar
}""",

"""@cstruct T {
	s::Cshort
}""",

"""@cstruct T {
	i::Cint
}""",

"""@cstruct T {
	l::Clong
}""",

"""@cstruct T {
	ll::Clonglong
}""",

"""@cstruct T {
	x::Cchar
	c::Cchar
}""",

"""@cstruct T {
	x::Cchar
	s::Cshort
}""",

"""@cstruct T {
	x::Cchar
	i::Cint
}""",

"""@cstruct T {
	x::Cchar
	l::Clong
}""",

"""@cstruct T {
	x::Cchar
	ll::Clonglong
}""",

"""@cstruct T {
	x::Cchar
	f::Cfloat
}""",

"""@cstruct T {
	x::Cchar
	d::Cdouble
}""",

"""@cstruct T {
	x::Cchar
	ld::Clongdouble
}""",

"""@cstruct T {
	c::Cchar:3
}""",

"""@cstruct T {
	s::Cshort:3
}""",

"""@cstruct T {
	i::Cint:3
}""",

"""@cstruct T {
	l::Clong:3
}""",

"""@cstruct T {
	ll::Clonglong:3
}""",

"""@cstruct T {
	x::Cchar:3
	c::Cchar
}""",

"""@cstruct T {
	x::Cchar:3
	s::Cshort
}""",

"""@cstruct T {
	x::Cchar:3
	i::Cint
}""",

"""@cstruct T {
	x::Cchar:3
	l::Clong
}""",

"""@cstruct T {
	x::Cchar:3
	l::Clonglong
}""",

"""@cstruct T {
	x::Cchar:3
	f::Cfloat
}""",

"""@cstruct T {
	x::Cchar:3
	d::Cdouble
}""",

"""@cstruct T {
	x::Cchar:3
	ld::Clongdouble
}""",

"""@cstruct T {
	c::Cchar:3
	x::Cchar
}""",

"""@cstruct T {
	s::Cshort:3
	x::Cchar
}""",

"""@cstruct T {
	i::Cint:3
	x::Cchar
}""",

"""@cstruct T {
	l::Clong:3
	x::Cchar
}""",

"""@cstruct T {
	l::Clonglong:3
	x::Cchar
}""",

"""@cstruct T {
	x::Cchar:3
	c::Cchar:3
}""",

"""@cstruct T {
	x::Cchar:3
	s::Cshort:3
}""",

"""@cstruct T {
	x::Cchar:3
	i::Cint:3
}""",

"""@cstruct T {
	x::Cchar:3
	l::Clong:3
}""",

"""@cstruct T {
	x::Cchar:3
	ll::Clonglong:3
}""",

"""@cstruct T {
	x::Cchar:3
	c::Cchar:5
}""",

"""@cstruct T {
	x::Cchar:3
	s::Cshort:13
}""",

"""@cstruct T {
	x::Cchar:3
	i::Cint:29
}""",

"""@cstruct T {
	x::Cchar:3
	l::Clong:61
}""",

"""@cstruct T {
	x::Cchar:3
	ll::Clonglong:61
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		c::Cchar:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		s::Cshort:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		i::Cint:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		l::Clong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		ll::Clonglong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		c::Cchar:3
	}
}""",

"""@cstruct T {
	x::Cshort:3
	@cstruct {
		s::Cshort:3
	}
}""",

"""@cstruct T {
	x::Cint:3
	@cstruct {
		i::Cint:3
	}
}""",

"""@cstruct T {
	x::Clong:3
	@cstruct {
		l::Clong:3
	}
}""",

"""@cstruct T {
	x::Clonglong:3
	@cstruct {
		ll::Clonglong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		c::Cchar:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		s::Cshort:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		i::Cint:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		l::Clong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		ll::Clonglong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		c::Cchar:3
	}
}""",

"""@cstruct T {
	x::Cshort:3
	@cunion {
		s::Cshort:3
	}
}""",

"""@cstruct T {
	x::Cint:3
	@cunion {
		i::Cint:3
	}
}""",

"""@cstruct T {
	x::Clong:3
	@cunion {
		l::Clong:3
	}
}""",

"""@cstruct T {
	x::Clonglong:3
	@cunion {
		ll::Clonglong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@calign sizeof(Cchar)*2
	@cstruct {
		c::Cchar:3
	}
}""",

"""@cstruct T {
	x::Cshort:3
	@calign sizeof(Cshort)*2
	@cstruct {
		s::Cshort:3
	}
}""",

"""@cstruct T {
	x::Cint:3
	@calign sizeof(Cint)*2
	@cstruct {
		i::Cint:3
	}
}""",

"""@cstruct T {
	x::Clong:3
	@calign sizeof(Clong)*2
	@cstruct {
		l::Clong:3
	}
}""",

"""@cstruct T {
	x::Clonglong:3
	@calign sizeof(Clonglong)*2
	@cstruct {
		ll::Clonglong:3
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	}
}""",

"""@cstruct T {
	x::Cshort:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	}
}""",

"""@cstruct T {
	x::Cint:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	}
}""",

"""@cstruct T {
	x::Clong:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	}
}""",

"""@cstruct T {
	x::Clonglong:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	}
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		c::Cchar:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		s::Cshort:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		i::Cint:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		l::Clong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		ll::Clonglong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		c::Cchar:3
	} __packed__
}""",

"""@cstruct T {
	x::Cshort:3
	@cstruct {
		s::Cshort:3
	} __packed__
}""",

"""@cstruct T {
	x::Cint:3
	@cstruct {
		i::Cint:3
	} __packed__
}""",

"""@cstruct T {
	x::Clong:3
	@cstruct {
		l::Clong:3
	} __packed__
}""",

"""@cstruct T {
	x::Clonglong:3
	@cstruct {
		ll::Clonglong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		c::Cchar:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		s::Cshort:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		i::Cint:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		l::Clong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		ll::Clonglong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cunion {
		c::Cchar:3
	} __packed__
}""",

"""@cstruct T {
	x::Cshort:3
	@cunion {
		s::Cshort:3
	} __packed__
}""",

"""@cstruct T {
	x::Cint:3
	@cunion {
		i::Cint:3
	} __packed__
}""",

"""@cstruct T {
	x::Clong:3
	@cunion {
		l::Clong:3
	} __packed__
}""",

"""@cstruct T {
	x::Clonglong:3
	@cunion {
		ll::Clonglong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@calign sizeof(Cchar)*2
	@cstruct {
		c::Cchar:3
	} __packed__
}""",

"""@cstruct T {
	x::Cshort:3
	@calign sizeof(Cshort)*2
	@cstruct {
		s::Cshort:3
	} __packed__
}""",

"""@cstruct T {
	x::Cint:3
	@calign sizeof(Cint)*2
	@cstruct {
		i::Cint:3
	} __packed__
}""",

"""@cstruct T {
	x::Clong:3
	@calign sizeof(Clong)*2
	@cstruct {
		l::Clong:3
	} __packed__
}""",

"""@cstruct T {
	x::Clonglong:3
	@calign sizeof(Clonglong)*2
	@cstruct {
		ll::Clonglong:3
	} __packed__
}""",

"""@cstruct T {
	x::Cchar:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	} __packed__
}""",

"""@cstruct T {
	x::Cshort:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	} __packed__
}""",

"""@cstruct T {
	x::Cint:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	} __packed__
}""",

"""@cstruct T {
	x::Clong:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	} __packed__
}""",

"""@cstruct T {
	x::Clonglong:3
	@cstruct {
		@calign sizeof(Cint)*2
		c::Cchar
	} __packed__
}""",

"""@cstruct T {
	e::@cenum {
		VAL1,
		VAL2,
		VAL3,
	}
}""",

"""@cstruct T {
	e::@cenum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	}
}""",

"""@cstruct T {
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	}
}""",

"""@cstruct T {
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	}
}""",

"""@cstruct T {
	x::Cchar
	e::@cenum {
		VAL1,
		VAL2,
		VAL3,
	}
}""",

"""@cstruct T {
	x::Cchar
	e::@cenum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	}
}""",

"""@cstruct T {
	x::Cchar
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	}
}""",

"""@cstruct T {
	x::Cchar
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	}
}""",

"""@cstruct T {
	x::Cchar:3
	e::@cenum {
		VAL1,
		VAL2,
		VAL3,
	}
}""",

"""@cstruct T {
	x::Cchar:3
	e::@cenum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	}
}""",

"""@cstruct T {
	x::Cchar:3
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	}
}""",

"""@cstruct T {
	x::Cchar:3
	e::@cenum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	}
}""",
]
