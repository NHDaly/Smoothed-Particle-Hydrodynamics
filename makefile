TARGET = Smoothed-Particle-Hydrodynamics

RM := rm -rf

SOURCES = src/PyramidalSimulation.cpp \
src/main.cpp \
src/owHelper.cpp \
src/owOpenCLSolver.cpp \
src/owPhysicsFluidSimulator.cpp \
src/owWorldSimulation.cpp

SRCEXT := cpp
SRCDIR := src
BUILDDIR = ./release
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))

CPP_DEPS = $(OBJECTS:.o=.d)

LIBS := -lpython2.7 -lGL -lGLU -lOpenCL -lrt -lglut


all : $(TARGET)

$(TARGET):$(OBJECTS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC C++ Linker'
	g++  -o $(BUILDDIR)/$(TARGET) $(OBJECTS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(BUILDDIR)
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/usr/include/python2.7 -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean : 
	-$(RM) $(OBJECTS)$(CPP_DEPS) $(BUILDDIR)/$(TARGET)
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:
