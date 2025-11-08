class_name ParticleManager extends GPUParticles2D

@export var particles: Array[GPUParticles2D]
## The particle that lasts the longest.
@export var longest_particle: GPUParticles2D

func _ready() -> void:
	longest_particle.finished.connect(particle_finished)
	start_particles()

func start_particles() -> void:
	for particle in particles:
		particle.emitting = true

func particle_finished() -> void:
	queue_free()
